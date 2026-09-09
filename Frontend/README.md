# Frontend

The frontend is the visible layer of Reunite. Its job is to make a difficult moment feel navigable: a visitor can understand the purpose quickly, a member can move through cases without friction, and every important action has a clear consequence.

The interface is organized around two worlds:

- the public story — home, about, and support;
- the protected workspace — case archive, photo search, reporting, profile, and administration.

The visual language uses warm paper tones, deep green, and coral signals to keep the product serious without becoming cold. Components live primarily in `src/App.tsx`; the shared visual vocabulary lives in `src/index.css`; API calls are kept in `src/lib/api.ts`.

## Useful knowledge

Routes are client-side paths and the deployment must serve `index.html` for them. The `_redirects` file exists for that reason. Runtime API configuration is supplied through `VITE_API_URL`; it must point to the backend `/api` base.

Images returned by the backend should use their signed `url`, not their private storage path. Authentication is cookie-based, so requests must retain credentials.

