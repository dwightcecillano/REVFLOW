-- RevFlow invitation-only workspace access foundation.
-- Apply only to the designated development Supabase project after review.
begin;
create table public.workspaces (
  id uuid primary key default gen_random_uuid(),
  name text not null check (length(btrim(name)) between 1 and 200),
  created_at timestamptz not null default now()
);
create table public.workspace_memberships (
  workspace_id uuid not null references public.workspaces(id) on delete cascade,
  user_id uuid not null references auth.users(id) on delete cascade,
  role text not null check (role in ('admin','client','va')),
  display_name text not null check (length(btrim(display_name)) between 1 and 150),
  active boolean not null default true,
  created_at timestamptz not null default now(),
  primary key (workspace_id,user_id)
);
create index workspace_memberships_user_idx on public.workspace_memberships(user_id) where active;
alter table public.workspaces enable row level security;
alter table public.workspace_memberships enable row level security;
revoke all on public.workspaces, public.workspace_memberships from public, anon, authenticated;
grant select on public.workspaces, public.workspace_memberships to authenticated;
grant select, insert, update, delete on public.workspaces, public.workspace_memberships to service_role;
create policy own_active_membership on public.workspace_memberships for select to authenticated
  using (user_id = (select auth.uid()) and active);
create policy accessible_workspace on public.workspaces for select to authenticated
  using (exists (select 1 from public.workspace_memberships m
    where m.workspace_id = workspaces.id and m.user_id = (select auth.uid()) and m.active));
-- No client-side writes are granted. Provision users and memberships through
-- trusted server/admin tooling only. A role never comes from browser input.
-- Disable public signups in Supabase Auth before using this project.
commit;
