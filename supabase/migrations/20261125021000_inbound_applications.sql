-- Internal RevFlow sales inbox, never accessible to anonymous or tenant users.
begin;
create table public.inbound_applications (
  id uuid primary key default gen_random_uuid(),
  full_name text not null check (length(btrim(full_name)) between 1 and 200),
  email text not null check (length(email) between 3 and 320),
  phone text not null check (length(phone) between 1 and 50),
  company text check (length(company) <= 200),
  business_type text not null check (length(business_type) between 1 and 150),
  plan text check (length(plan) <= 200),
  location text check (length(location) <= 200),
  start_timeline text check (length(start_timeline) <= 100),
  message text check (length(message) <= 4000),
  consent boolean not null check (consent),
  source text not null default 'website',
  status text not null default 'new' check (status in ('new','contacted','qualified','booked','closed','disqualified')),
  received_at timestamptz not null default now()
);
create index inbound_applications_status_received_idx on public.inbound_applications(status,received_at desc);
alter table public.inbound_applications enable row level security;
revoke all on public.inbound_applications from public, anon, authenticated;
grant select, insert, update, delete on public.inbound_applications to service_role;
-- Use a trusted server endpoint with anti-abuse controls and server validation;
-- do not expose service_role or allow direct anonymous insertion.
commit;
