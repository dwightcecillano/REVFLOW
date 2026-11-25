-- Run only in a disposable local/staging Supabase instance after migrations.
-- Each check raises an exception on failure; all synthetic data is rolled back.
begin;
insert into auth.users (id,aud,role,email) values
('11111111-1111-4111-8111-111111111111','authenticated','authenticated','revflow-test-a@example.invalid'),
('22222222-2222-4222-8222-222222222222','authenticated','authenticated','revflow-test-b@example.invalid'),
('33333333-3333-4333-8333-333333333333','authenticated','authenticated','revflow-test-inactive@example.invalid'),
('44444444-4444-4444-8444-444444444444','authenticated','authenticated','revflow-test-unassigned@example.invalid');
insert into public.workspaces(id,name) values
('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','Synthetic A'),
('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','Synthetic B');
insert into public.workspace_memberships(workspace_id,user_id,role,display_name,active) values
('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','11111111-1111-4111-8111-111111111111','admin','Test A',true),
('bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb','22222222-2222-4222-8222-222222222222','client','Test B',true),
('aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa','33333333-3333-4333-8333-333333333333','va','Inactive',false);
insert into public.inbound_applications(full_name,email,phone,business_type,consent)
values ('Synthetic inquiry','revflow-test@example.invalid','2025550100','Other',true);

set local role anon;
do $$ begin
  if has_table_privilege(current_user,'public.workspaces','SELECT') or
     has_table_privilege(current_user,'public.workspace_memberships','SELECT') or
     has_table_privilege(current_user,'public.inbound_applications','SELECT,INSERT,UPDATE,DELETE')
  then raise exception 'FAIL: anonymous grants'; end if;
end $$;
reset role;

set local role authenticated;
select set_config('request.jwt.claim.sub','11111111-1111-4111-8111-111111111111',true);
select set_config('request.jwt.claims','{"sub":"11111111-1111-4111-8111-111111111111","role":"authenticated"}',true);
do $$ begin
  if (select count(*) from public.workspaces) <> 1 or
     not exists(select 1 from public.workspaces where id='aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa') or
     (select count(*) from public.workspace_memberships) <> 1
  then raise exception 'FAIL: tenant A scope'; end if;
  if has_table_privilege(current_user,'public.workspace_memberships','INSERT,UPDATE,DELETE') or
     has_table_privilege(current_user,'public.workspaces','INSERT,UPDATE,DELETE') or
     has_table_privilege(current_user,'public.inbound_applications','SELECT,INSERT,UPDATE,DELETE')
  then raise exception 'FAIL: unauthorized writes or sales inbox grants'; end if;
end $$;
select set_config('request.jwt.claim.sub','22222222-2222-4222-8222-222222222222',true);
select set_config('request.jwt.claims','{"sub":"22222222-2222-4222-8222-222222222222","role":"authenticated"}',true);
do $$ begin
  if (select count(*) from public.workspaces) <> 1 or
     not exists(select 1 from public.workspaces where id='bbbbbbbb-bbbb-4bbb-8bbb-bbbbbbbbbbbb') or
     (select count(*) from public.workspace_memberships) <> 1
  then raise exception 'FAIL: tenant B scope'; end if;
end $$;
select set_config('request.jwt.claim.sub','33333333-3333-4333-8333-333333333333',true);
select set_config('request.jwt.claims','{"sub":"33333333-3333-4333-8333-333333333333","role":"authenticated"}',true);
do $$ begin
  if exists(select 1 from public.workspaces) or exists(select 1 from public.workspace_memberships)
  then raise exception 'FAIL: inactive user scope'; end if;
end $$;
select set_config('request.jwt.claim.sub','44444444-4444-4444-8444-444444444444',true);
select set_config('request.jwt.claims','{"sub":"44444444-4444-4444-8444-444444444444","role":"authenticated"}',true);
do $$ begin
  if exists(select 1 from public.workspaces) or exists(select 1 from public.workspace_memberships)
  then raise exception 'FAIL: unassigned user scope'; end if;
end $$;
reset role;
rollback;
