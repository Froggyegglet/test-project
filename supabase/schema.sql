create extension if not exists pgcrypto;

create table if not exists equipment_types (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  name text not null,
  category text not null check (category in ('audio', 'lighting', 'staging', 'dj', 'power', 'video')),
  keywords text[] not null default '{}',
  use_cases text[] not null default '{}',
  buy_or_hire_preference text not null default 'both' check (buy_or_hire_preference in ('buy', 'hire', 'both', 'quote')),
  min_people integer not null default 0 check (min_people >= 0),
  max_people integer check (max_people is null or max_people >= min_people),
  created_at timestamptz not null default now()
);

create table if not exists suppliers (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  city text not null,
  state text not null,
  service_cities text[] not null default '{}',
  supplier_type text not null default 'hire' check (supplier_type in ('hire', 'retail', 'production', 'marketplace')),
  categories text[] not null default '{}',
  event_fit text[] not null default '{}',
  website text,
  email text,
  phone text,
  abn text,
  google_place_id text,
  verified boolean not null default false,
  paid_partner boolean not null default false,
  priority_score integer not null default 0,
  summary text,
  created_at timestamptz not null default now(),
  unique (name, city)
);

create table if not exists supplier_products (
  id uuid primary key default gen_random_uuid(),
  supplier_id uuid not null references suppliers(id) on delete cascade,
  equipment_type_id uuid not null references equipment_types(id) on delete restrict,
  product_name text not null,
  brand text,
  model text,
  buy_or_hire text not null default 'hire' check (buy_or_hire in ('buy', 'hire', 'quote')),
  price_from numeric(10, 2),
  price_to numeric(10, 2),
  price_type text not null default 'quote' check (price_type in ('fixed', 'from', 'range', 'quote')),
  url text,
  cities text[] not null default '{}',
  stock_status text not null default 'unknown' check (stock_status in ('in_stock', 'limited', 'out_of_stock', 'unknown')),
  last_checked_at timestamptz,
  created_at timestamptz not null default now(),
  unique (supplier_id, equipment_type_id, product_name)
);

create table if not exists lead_requests (
  id uuid primary key default gen_random_uuid(),
  name text,
  email text not null,
  phone text,
  city text not null,
  state text,
  suburb text,
  event_type text not null check (event_type in ('wedding', 'party', 'corporate', 'dj', 'stage')),
  event_date date,
  guests integer check (guests is null or guests > 0),
  venue_size text check (venue_size is null or venue_size in ('small', 'medium', 'large', 'outdoor')),
  vibe text check (vibe is null or vibe in ('soft', 'club', 'stage', 'brand')),
  budget_value integer,
  notes text,
  recommended_equipment jsonb not null default '{}'::jsonb,
  matched_suppliers jsonb not null default '[]'::jsonb,
  source text not null default 'website',
  status text not null default 'new' check (status in ('new', 'routed', 'won', 'lost', 'spam')),
  created_at timestamptz not null default now()
);

create index if not exists equipment_types_category_idx on equipment_types(category);
create index if not exists suppliers_city_idx on suppliers(city);
create index if not exists suppliers_verified_idx on suppliers(verified, paid_partner);
create index if not exists suppliers_event_fit_idx on suppliers using gin(event_fit);
create index if not exists supplier_products_supplier_idx on supplier_products(supplier_id);
create index if not exists supplier_products_equipment_idx on supplier_products(equipment_type_id);
create index if not exists supplier_products_cities_idx on supplier_products using gin(cities);
create index if not exists lead_requests_city_created_idx on lead_requests(city, created_at desc);
create index if not exists lead_requests_status_idx on lead_requests(status);

alter table equipment_types enable row level security;
alter table suppliers enable row level security;
alter table supplier_products enable row level security;
alter table lead_requests enable row level security;

drop policy if exists "Public can read equipment types" on equipment_types;
create policy "Public can read equipment types"
on equipment_types for select
to anon, authenticated
using (true);

drop policy if exists "Public can read visible suppliers" on suppliers;
drop policy if exists "Public can read suppliers" on suppliers;
create policy "Public can read suppliers"
on suppliers for select
to anon, authenticated
using (true);

drop policy if exists "Public can read visible supplier products" on supplier_products;
drop policy if exists "Public can read supplier products" on supplier_products;
create policy "Public can read supplier products"
on supplier_products for select
to anon, authenticated
using (true);

drop policy if exists "Public can create lead requests" on lead_requests;
create policy "Public can create lead requests"
on lead_requests for insert
to anon, authenticated
with check (
  email is not null
  and city is not null
  and event_type is not null
);

drop policy if exists "Authenticated can read lead requests" on lead_requests;
create policy "Authenticated can read lead requests"
on lead_requests for select
to authenticated
using (true);
