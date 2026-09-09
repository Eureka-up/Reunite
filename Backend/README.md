# Backend

The backend is the trust boundary of Reunite. It decides who may create or change information, keeps private sessions in HTTP-only cookies, coordinates report and comment data, and mediates access to stored photographs and AI search.

Its most important responsibility is not merely returning data; it is preserving the meaning of the data. Ownership checks protect reports, administrator checks protect account operations, and signed image URLs keep storage objects private while still allowing the interface to display them.

## Useful knowledge

`api.py` is the Vercel entrypoint and exposes the `/api` routes. The database is PostgreSQL, photographs are stored through Supabase Storage, and AI calls are made to the configured Gradio Space. `FRONTEND_URL` must contain the exact deployed frontend origin for credentialed CORS to work.

Production requires a real `JWT_SECRET`. `AI_SPACE`, `AI_TOKEN`, database variables, and Supabase service-role credentials belong only in the deployment environment; never expose them to the frontend.

