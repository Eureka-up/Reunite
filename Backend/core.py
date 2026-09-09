from __future__ import annotations

import os
from dataclasses import dataclass
from pathlib import Path
from typing import Any, Protocol, Sequence

import cv2
import numpy as np
import torch
import torch.nn as nn
import torch.nn.functional as F
from PIL import Image
from torchvision import models, transforms

EMBEDDING_DIM = 512

def serialize_embedding(embedding: Sequence[float]) -> bytes:
    vector = np.asarray(embedding, dtype=np.float32)
    if vector.ndim != 1 or vector.size != EMBEDDING_DIM:
        raise ValueError(f"Expected a {EMBEDDING_DIM}-dimension embedding.")
    return vector.tobytes()

def deserialize_embedding(value: bytes | memoryview) -> np.ndarray:
    vector = np.frombuffer(bytes(value), dtype=np.float32)
    if vector.size != EMBEDDING_DIM:
        raise ValueError(f"Expected a {EMBEDDING_DIM}-dimension embedding.")
    return vector

class EmbeddingError(ValueError):
    pass

@dataclass(frozen=True)
class SearchMatch:
    record_id: str
    similarity: float
    metadata: dict[str, Any] | None = None

class EmbeddingRepository(Protocol):
    def search_by_embedding(self, embedding: list[float], *, limit: int, threshold: float) -> Sequence[SearchMatch]: ...

class Siamese(nn.Module):
    def __init__(self) -> None:
        super().__init__()
        self.backbone = models.resnet50(weights=None)
        self.backbone.fc = nn.Identity()
        self.head = nn.Sequential(nn.Linear(2048, 1024), nn.ReLU(), nn.Linear(1024, EMBEDDING_DIM))

    def forward(self, image: torch.Tensor) -> torch.Tensor:
        return F.normalize(self.head(self.backbone(image)), p=2, dim=1)

class EmbeddingService:
    def __init__(self, model_path: str | Path | None = None) -> None:
        configured_path = model_path or os.getenv("EMBEDDING_MODEL_PATH")
        if not configured_path:
            raise ValueError("EMBEDDING_MODEL_PATH is required; no model fallback is used.")
        configured = Path(configured_path)
        base_dir = Path(__file__).parent
        self.model_path = (base_dir / configured).resolve() if not configured.is_absolute() else configured
        self.device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
        self._model: Siamese | None = None
        self._preprocess = transforms.Compose([transforms.Resize((224, 224)), transforms.ToTensor()])

    def warm_up(self) -> None:
        self._get_model()

    def embed_image(self, image_bytes: bytes) -> list[float]:
        if not image_bytes:
            raise EmbeddingError("Image data is required.")
        encoded = np.frombuffer(image_bytes, np.uint8)
        image = cv2.imdecode(encoded, cv2.IMREAD_COLOR)
        if image is None:
            raise EmbeddingError("Could not decode the image. Upload a valid image file.")
        rgb_image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
        tensor = self._preprocess(Image.fromarray(rgb_image)).unsqueeze(0).to(self.device)
        with torch.inference_mode():
            vector = self._get_model()(tensor).squeeze(0).cpu().numpy().astype(np.float32)
        if vector.size != EMBEDDING_DIM or not np.isfinite(vector).all():
            raise EmbeddingError("The model produced an invalid embedding.")
        return vector.tolist()

    def search(self, image_bytes: bytes, repository: EmbeddingRepository, *, limit: int = 5, threshold: float = 0.38) -> Sequence[SearchMatch]:
        if limit < 1:
            raise ValueError("limit must be at least 1.")
        if not -1 <= threshold <= 1:
            raise ValueError("threshold must be between -1 and 1.")
        return repository.search_by_embedding(self.embed_image(image_bytes), limit=limit, threshold=threshold)

    def _get_model(self) -> Siamese:
        if self._model is None:
            if not self.model_path.is_file():
                raise FileNotFoundError(f"Embedding checkpoint not found: {self.model_path}")
            checkpoint = torch.load(self.model_path, map_location=self.device)
            if isinstance(checkpoint, dict):
                checkpoint = checkpoint.get("state_dict", checkpoint.get("model_state_dict", checkpoint))
            model = Siamese().to(self.device)
            model.load_state_dict(checkpoint)
            model.eval()
            self._model = model
        return self._model

embedding_service = EmbeddingService()

def embed_image(image_bytes: bytes) -> list[float]:
    return embedding_service.embed_image(image_bytes)
