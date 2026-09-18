-- v15 schema
alter table public.wash_receptions add column if not exists wash_date date;
alter table public.wash_receptions add column if not exists memo text default '';
alter table public.wash_receptions add column if not exists seat_cover boolean not null default false;
alter table public.wash_receptions add column if not exists amount integer not null default 1300;
create table if not exists public.wash_available_days (
 wash_date date primary key,
 is_open boolean not null default true,
 capacity integer not null default 5,
 created_at timestamptz not null default now()
);
alter table public.wash_available_days enable row level security;
drop policy if exists "anon read wash days" on public.wash_available_days;
drop policy if exists "anon insert wash days" on public.wash_available_days;
drop policy if exists "anon update wash days" on public.wash_available_days;
drop policy if exists "anon delete wash days" on public.wash_available_days;
create policy "anon read wash days" on public.wash_available_days for select to anon using (true);
create policy "anon insert wash days" on public.wash_available_days for insert to anon with check (true);
create policy "anon update wash days" on public.wash_available_days for update to anon using (true) with check (true);
create policy "anon delete wash days" on public.wash_available_days for delete to anon using (true);
