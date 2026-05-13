insert into equipment_types (slug, name, category, keywords, use_cases, buy_or_hire_preference, min_people, max_people)
values
  ('powered_pa_12', '12-inch powered PA speaker', 'audio', array['speaker','pa','powered speaker','12 inch'], array['wedding','party','corporate','dj','stage'], 'both', 30, 160),
  ('powered_pa_15', '15-inch powered PA speaker', 'audio', array['speaker','pa','powered speaker','15 inch'], array['party','dj','stage'], 'both', 80, 260),
  ('subwoofer_18', '18-inch subwoofer', 'audio', array['sub','subwoofer','bass','18 inch'], array['party','dj','stage'], 'hire', 80, null),
  ('wireless_mic', 'Wireless microphone', 'audio', array['wireless mic','microphone','speech'], array['wedding','corporate','stage'], 'both', 20, null),
  ('small_mixer', 'Small audio mixer', 'audio', array['mixer','audio mixer','inputs'], array['wedding','party','corporate','stage'], 'both', 20, 180),
  ('stage_monitor', 'Stage monitor', 'audio', array['foldback','monitor','wedge'], array['dj','stage'], 'hire', 60, null),
  ('dj_controller', 'DJ controller', 'dj', array['dj controller','decks','controller'], array['party','dj'], 'buy', 20, null),
  ('wireless_uplight', 'Wireless uplight', 'lighting', array['uplight','wireless uplight','ambient'], array['wedding','party','corporate'], 'hire', 20, null),
  ('moving_head', 'Moving head light', 'lighting', array['moving head','beam','spot'], array['party','dj','stage'], 'hire', 60, null),
  ('wash_light', 'LED wash light', 'lighting', array['wash','led wash','stage wash'], array['corporate','stage','wedding'], 'hire', 40, null),
  ('dance_floor_light', 'Dance floor light', 'lighting', array['party light','dance floor','effect light'], array['wedding','party','dj'], 'hire', 30, null),
  ('haze_machine', 'Haze machine', 'lighting', array['haze','atmosphere','fog'], array['party','dj','stage'], 'hire', 60, null),
  ('portable_stage', 'Portable stage deck', 'staging', array['stage','deck','riser'], array['corporate','stage'], 'hire', 60, null)
on conflict (slug) do update
set
  name = excluded.name,
  category = excluded.category,
  keywords = excluded.keywords,
  use_cases = excluded.use_cases,
  buy_or_hire_preference = excluded.buy_or_hire_preference,
  min_people = excluded.min_people,
  max_people = excluded.max_people;

insert into suppliers (name, city, state, service_cities, supplier_type, categories, event_fit, website, email, verified, paid_partner, priority_score, summary)
values
  ('Harbour AV Hire', 'Sydney', 'NSW', array['Sydney','Parramatta','North Sydney'], 'hire', array['PA packages','Wireless mics','Uplights'], array['wedding','corporate','party'], 'https://example.com', 'quotes@example.com', true, true, 90, 'Package hire for receptions, speeches and medium rooms.'),
  ('Store DJ', 'Sydney', 'NSW', array['Sydney'], 'retail', array['Speakers','Mixers','DJ controllers'], array['dj','party','stage'], 'https://example.com', 'retail@example.com', true, false, 60, 'Retail alternatives for buyers who run events regularly.'),
  ('Wedding Glow Co', 'Sydney', 'NSW', array['Sydney','Parramatta'], 'hire', array['Uplights','Dance floor','Warm wash'], array['wedding','party'], 'https://example.com', 'events@example.com', true, false, 75, 'Reception-friendly lighting packages for soft premium rooms.'),
  ('Laneway Production', 'Melbourne', 'VIC', array['Melbourne','St Kilda','Richmond'], 'production', array['Stage wash','PA','Operators'], array['corporate','stage','dj'], 'https://example.com', 'melbourne@example.com', true, true, 88, 'End-to-end AV for brand launches and small stage shows.'),
  ('Northside Party Hire', 'Brisbane', 'QLD', array['Brisbane','Fortitude Valley'], 'hire', array['Party lights','Subs','Microphones'], array['party','dj','wedding'], 'https://example.com', 'brisbane@example.com', true, false, 70, 'Compact sound and lighting packages for private functions.'),
  ('West Coast AV', 'Perth', 'WA', array['Perth','Fremantle'], 'production', array['Corporate AV','PA','Lighting'], array['corporate','stage','wedding'], 'https://example.com', 'perth@example.com', true, false, 70, 'Reliable conference and presentation AV packages.'),
  ('Festival City Sound', 'Adelaide', 'SA', array['Adelaide'], 'hire', array['PA speakers','Subwoofers','Stage monitors'], array['stage','dj','party'], 'https://example.com', 'adelaide@example.com', true, false, 66, 'Audio-first hire options for performances and dance floors.'),
  ('Capital Event Tech', 'Canberra', 'ACT', array['Canberra'], 'production', array['Corporate AV','Wireless mics','Stage wash'], array['corporate','wedding','stage'], 'https://example.com', 'canberra@example.com', true, false, 66, 'Formal event AV with microphones, projection and room coverage.'),
  ('Coastline DJ Hire', 'Gold Coast', 'QLD', array['Gold Coast','Surfers Paradise'], 'hire', array['DJ decks','Subs','Moving heads'], array['dj','party'], 'https://example.com', 'goldcoast@example.com', true, false, 68, 'Club-style packages for parties and DJ-led events.')
on conflict (name, city) do update
set
  state = excluded.state,
  service_cities = excluded.service_cities,
  supplier_type = excluded.supplier_type,
  categories = excluded.categories,
  event_fit = excluded.event_fit,
  website = excluded.website,
  email = excluded.email,
  verified = excluded.verified,
  paid_partner = excluded.paid_partner,
  priority_score = excluded.priority_score,
  summary = excluded.summary;

insert into supplier_products (supplier_id, equipment_type_id, product_name, buy_or_hire, price_from, price_to, price_type, cities, stock_status, last_checked_at)
select s.id, e.id, product_name, buy_or_hire, price_from, price_to, price_type, cities, 'unknown', now()
from (
  values
    ('Harbour AV Hire', 'Sydney', 'powered_pa_12', '2 x 12-inch PA speaker hire package', 'hire', 280, 420, 'range', array['Sydney','Parramatta']),
    ('Harbour AV Hire', 'Sydney', 'wireless_mic', 'Wireless microphone hire', 'hire', 80, 140, 'range', array['Sydney','Parramatta']),
    ('Harbour AV Hire', 'Sydney', 'wireless_uplight', '12 x wireless uplight package', 'hire', 360, 600, 'range', array['Sydney','Parramatta']),
    ('Store DJ', 'Sydney', 'powered_pa_12', '12-inch powered speaker retail options', 'buy', 599, null, 'from', array['Sydney']),
    ('Store DJ', 'Sydney', 'small_mixer', 'Compact mixer retail options', 'buy', 189, null, 'from', array['Sydney']),
    ('Wedding Glow Co', 'Sydney', 'wireless_uplight', 'Wedding uplight package', 'hire', 420, 720, 'range', array['Sydney','Parramatta']),
    ('Laneway Production', 'Melbourne', 'wash_light', 'Stage wash lighting package', 'hire', 500, 900, 'range', array['Melbourne']),
    ('Laneway Production', 'Melbourne', 'powered_pa_15', 'Medium venue PA package', 'hire', 650, 1200, 'range', array['Melbourne']),
    ('Northside Party Hire', 'Brisbane', 'subwoofer_18', '18-inch subwoofer hire', 'hire', 160, 260, 'range', array['Brisbane']),
    ('West Coast AV', 'Perth', 'wireless_mic', 'Corporate wireless mic kit', 'hire', 160, 300, 'range', array['Perth']),
    ('Festival City Sound', 'Adelaide', 'stage_monitor', 'Stage monitor hire', 'hire', 120, 220, 'range', array['Adelaide']),
    ('Capital Event Tech', 'Canberra', 'wash_light', 'Presentation stage wash package', 'hire', 420, 800, 'range', array['Canberra']),
    ('Coastline DJ Hire', 'Gold Coast', 'moving_head', '2 x moving head package', 'hire', 260, 520, 'range', array['Gold Coast'])
) as rows(supplier_name, supplier_city, equipment_slug, product_name, buy_or_hire, price_from, price_to, price_type, cities)
join suppliers s on s.name = rows.supplier_name and s.city = rows.supplier_city
join equipment_types e on e.slug = rows.equipment_slug
on conflict (supplier_id, equipment_type_id, product_name) do update
set
  buy_or_hire = excluded.buy_or_hire,
  price_from = excluded.price_from,
  price_to = excluded.price_to,
  price_type = excluded.price_type,
  cities = excluded.cities,
  last_checked_at = excluded.last_checked_at;
