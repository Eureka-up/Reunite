"""Download and unpack the public Reunite encoder checkpoint during image build."""
from pathlib import Path
from urllib.request import Request, urlopen
from zipfile import ZipFile
import os
import shutil
import tempfile

URL = os.getenv(
    "MODEL_DOWNLOAD_URL",
    "https://www.kaggle.com/api/v1/datasets/download/mhmdelshoraky/best-encoder-model?datasetVersionNumber=1",
)
destination = Path(os.getenv("MODEL_DIR", "/app/model"))
destination.mkdir(parents=True, exist_ok=True)

with tempfile.TemporaryDirectory() as temp_dir:
    archive = Path(temp_dir) / "model.zip"
    request = Request(URL, headers={"User-Agent": "Reunite deployment"})
    with urlopen(request, timeout=300) as response, archive.open("wb") as output:
        shutil.copyfileobj(response, output)

    with ZipFile(archive) as zipped:
        candidates = [
            entry for entry in zipped.infolist()
            if not entry.is_dir() and Path(entry.filename).suffix.lower() in {".pt", ".pth", ".ckpt"}
        ]
        if not candidates:
            raise RuntimeError("The Kaggle archive does not contain a .pt, .pth, or .ckpt checkpoint.")
        selected = candidates[0]
        with zipped.open(selected) as source, (destination / "encoder.pth").open("wb") as output:
            shutil.copyfileobj(source, output)

print(f"Downloaded encoder checkpoint: {selected.filename}")
