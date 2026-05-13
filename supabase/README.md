# EventRig AU Supabase Setup

1. Create a Supabase project.
2. Open SQL Editor and run `schema.sql`.
3. Run `seed.sql` to add starter equipment types, suppliers and product/package mappings.
4. In Project Settings -> API, copy the Project URL and anon public key.
5. Put those values in `supabase-config.js`.
6. Run the site with a local server:

```powershell
cd "C:\Users\Event Lighting\Documents\Codex\2026-05-13\omc"
python -m http.server 5173
```

Then open `http://localhost:5173`.

## Adding More Suppliers

For quick manual entry, add rows to `suppliers` and `supplier_products`.

Recommended supplier sources:

- Google Places API for discovery: store `google_place_id`, then manually verify before marking `verified = true`.
- Supplier onboarding form: let companies submit ABN, service cities, categories and common packages.
- ABN Lookup for verification: use ABN/GST status as an admin check, not as the main discovery source.
- CSV import for your own researched list.

Do not try to import every product SKU at the start. Map real products and packages to stable `equipment_types`, such as `powered_pa_12`, `wireless_uplight` and `moving_head`.
