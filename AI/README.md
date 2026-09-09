# AI service

This service is the visual memory of Reunite. It receives a photograph and returns a fixed-length embedding: a numerical description that lets the backend compare a new image with photographs attached to open reports.

The service is intentionally small. It does one thing at the edge of the system so the main application can stay focused on people, permissions, and conversations. The backend calls the Gradio endpoint configured as `/embed` and expects a 512-value embedding.

## Useful knowledge

The Space is the runtime home for `app.py`. The public interface is not the product interface; it is an internal capability consumed by the backend through `gradio_client`. Keep the output shape stable, because the database comparison layer depends on the embedding dimension.

The AI result is a similarity signal, not proof of identity. Product copy and moderation should continue to treat matches as leads that require human judgment.

