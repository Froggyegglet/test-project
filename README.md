# EventRig AU

Apple-inspired SaaS MVP for Australian event AV planning.

EventRig AU recommends lighting, audio and local suppliers based on city, event type, guests, venue size, vibe and budget. It can run fully as a static site with local sample data, or connect to Supabase for live supplier matching and lead capture.

## Run locally

```powershell
python -m http.server 5173
```

Open:

```text
http://localhost:5173
```

## Supabase

1. Run `supabase/schema.sql` in the Supabase SQL Editor.
2. Run `supabase/seed.sql`.
3. Copy your Project URL and anon public key into `supabase-config.js`.

If Supabase is not configured, the app falls back to `suppliers.js`.
