create table if not exists analyses (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  platform text not null,
  file_name text,
  date_range_start date,
  date_range_end date,
  status text not null default 'pending',
  total_spend numeric,
  total_impressions bigint,
  total_clicks bigint,
  total_conversions numeric,
  overall_ctr numeric,
  overall_cpc numeric,
  overall_cpm numeric,
  overall_cpa numeric,
  overall_roas numeric,
  executive_summary text,
  executive_summary_source text,
  executive_summary_confidence numeric,
  executive_summary_review_status text default 'unreviewed'
);

alter table analyses enable row level security;
drop policy if exists "analyses_v1_read" on analyses;
create policy "analyses_v1_read" on analyses for select using (true);
drop policy if exists "analyses_v1_write" on analyses;
create policy "analyses_v1_write" on analyses for all using (true) with check (true);

create table if not exists campaigns (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  analysis_id uuid not null references analyses(id) on delete cascade,
  campaign_name text not null,
  spend numeric,
  impressions bigint,
  clicks bigint,
  conversions numeric,
  ctr numeric,
  cpc numeric,
  cpm numeric,
  cpa numeric,
  roas numeric,
  performance_label text,
  performance_label_source text,
  performance_label_confidence numeric,
  performance_label_review_status text default 'unreviewed'
);

alter table campaigns enable row level security;
drop policy if exists "campaigns_v1_read" on campaigns;
create policy "campaigns_v1_read" on campaigns for select using (true);
drop policy if exists "campaigns_v1_write" on campaigns;
create policy "campaigns_v1_write" on campaigns for all using (true) with check (true);

create table if not exists ad_sets (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  analysis_id uuid not null references analyses(id) on delete cascade,
  campaign_id uuid references campaigns(id) on delete cascade,
  ad_set_name text not null,
  spend numeric,
  impressions bigint,
  clicks bigint,
  conversions numeric,
  ctr numeric,
  cpc numeric,
  cpm numeric,
  cpa numeric,
  roas numeric,
  performance_label text,
  performance_label_source text,
  performance_label_confidence numeric,
  performance_label_review_status text default 'unreviewed'
);

alter table ad_sets enable row level security;
drop policy if exists "ad_sets_v1_read" on ad_sets;
create policy "ad_sets_v1_read" on ad_sets for select using (true);
drop policy if exists "ad_sets_v1_write" on ad_sets;
create policy "ad_sets_v1_write" on ad_sets for all using (true) with check (true);

create table if not exists ads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  analysis_id uuid not null references analyses(id) on delete cascade,
  ad_set_id uuid references ad_sets(id) on delete cascade,
  ad_name text not null,
  spend numeric,
  impressions bigint,
  clicks bigint,
  conversions numeric,
  ctr numeric,
  cpc numeric,
  cpm numeric,
  cpa numeric,
  roas numeric,
  performance_label text,
  performance_label_source text,
  performance_label_confidence numeric,
  performance_label_review_status text default 'unreviewed'
);

alter table ads enable row level security;
drop policy if exists "ads_v1_read" on ads;
create policy "ads_v1_read" on ads for select using (true);
drop policy if exists "ads_v1_write" on ads;
create policy "ads_v1_write" on ads for all using (true) with check (true);

create table if not exists recommendations (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  analysis_id uuid not null references analyses(id) on delete cascade,
  priority integer not null,
  category text not null,
  action_label text not null,
  rationale text,
  rationale_source text,
  rationale_confidence numeric,
  rationale_review_status text default 'unreviewed',
  target_entity_type text,
  target_entity_name text,
  status text not null default 'pending'
);

alter table recommendations enable row level security;
drop policy if exists "recommendations_v1_read" on recommendations;
create policy "recommendations_v1_read" on recommendations for select using (true);
drop policy if exists "recommendations_v1_write" on recommendations;
create policy "recommendations_v1_write" on recommendations for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  action text not null,
  entity_type text not null,
  entity_id uuid,
  detail jsonb
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into analyses (id, name, platform, file_name, date_range_start, date_range_end, status, total_spend, total_impressions, total_clicks, total_conversions, overall_ctr, overall_cpc, overall_cpm, overall_cpa, overall_roas, executive_summary, executive_summary_source, executive_summary_confidence, executive_summary_review_status) values
  ('a1000000-0000-0000-0000-000000000001', 'Meta Ads – June 2025', 'meta', 'meta_june_2025.csv', '2025-06-01', '2025-06-30', 'complete', 12400.00, 1820000, 36400, 410, 0.02, 0.34, 6.81, 30.24, 3.8, 'Your Meta campaigns delivered a 3.8x ROAS in June. The Retargeting – Warm Audience ad set drove 55% of conversions at a CPA 40% below average. Prospecting campaigns need creative refresh — CTR fell 18% week-over-week.', 'openai/gpt-4o', 0.91, 'reviewed'),
  ('a1000000-0000-0000-0000-000000000002', 'Google Ads – June 2025', 'google', 'google_june_2025.csv', '2025-06-01', '2025-06-30', 'complete', 8750.00, 940000, 28100, 295, 0.03, 0.31, 9.31, 29.66, 4.2, 'Google Search campaigns achieved a 4.2x ROAS. Brand keywords converted at 9.1x ROAS. Non-brand Shopping campaigns are over-spending with a 1.4x ROAS — recommend budget reallocation.', 'openai/gpt-4o', 0.88, 'reviewed'),
  ('a1000000-0000-0000-0000-000000000003', 'TikTok Ads – May 2025', 'tiktok', 'tiktok_may_2025.csv', '2025-05-01', '2025-05-31', 'complete', 4200.00, 3100000, 21700, 88, 0.007, 0.19, 1.35, 47.73, 1.9, 'TikTok drove strong top-of-funnel reach at $1.35 CPM but conversion rates are low. The UGC creative outperformed branded video by 3x on CTR. Consider A/B testing a stronger CTA overlay.', 'openai/gpt-4o', 0.85, 'unreviewed');

insert into campaigns (id, analysis_id, campaign_name, spend, impressions, clicks, conversions, ctr, cpc, cpm, cpa, roas, performance_label, performance_label_source, performance_label_confidence, performance_label_review_status) values
  ('c1000000-0000-0000-0000-000000000001', 'a1000000-0000-0000-0000-000000000001', 'Retargeting – Warm Audience', 3800.00, 420000, 16800, 226, 0.04, 0.226, 9.05, 16.81, 6.2, 'top_performer', 'openai/gpt-4o', 0.95, 'reviewed'),
  ('c1000000-0000-0000-0000-000000000002', 'a1000000-0000-0000-0000-000000000001', 'Prospecting – Lookalike 1%', 5200.00, 980000, 14700, 142, 0.015, 0.354, 5.31, 36.62, 2.8, 'underperformer', 'openai/gpt-4o', 0.89, 'reviewed'),
  ('c1000000-0000-0000-0000-000000000003', 'a1000000-0000-0000-0000-000000000002', 'Brand Search', 2100.00, 210000, 12600, 191, 0.06, 0.167, 10.0, 10.99, 9.1, 'top_performer', 'openai/gpt-4o', 0.97, 'reviewed'),
  ('c1000000-0000-0000-0000-000000000004', 'a1000000-0000-0000-0000-000000000002', 'Shopping – Non-Brand', 4300.00, 480000, 9600, 61, 0.02, 0.448, 8.96, 70.49, 1.4, 'underperformer', 'openai/gpt-4o', 0.92, 'reviewed');

insert into recommendations (analysis_id, priority, category, action_label, rationale, rationale_source, rationale_confidence, rationale_review_status, target_entity_type, target_entity_name, status) values
  ('a1000000-0000-0000-0000-000000000001', 1, 'budget', 'Increase budget on Retargeting – Warm Audience by 30%', 'This campaign delivers a 6.2x ROAS at a CPA 44% below account average. Scaling budget here has the highest expected return.', 'openai/gpt-4o', 0.93, 'reviewed', 'campaign', 'Retargeting – Warm Audience', 'pending'),
  ('a1000000-0000-0000-0000-000000000001', 2, 'creative', 'Test 3 new creatives in Prospecting – Lookalike 1%', 'CTR dropped 18% in the final two weeks, indicating creative fatigue. Fresh static and video variants recommended.', 'openai/gpt-4o', 0.87, 'reviewed', 'campaign', 'Prospecting – Lookalike 1%', 'pending'),
  ('a1000000-0000-0000-0000-000000000002', 1, 'budget', 'Reallocate 40% of Shopping – Non-Brand budget to Brand Search', 'Brand Search ROAS is 9.1x vs 1.4x for Non-Brand Shopping. Reallocation expected to lift overall account ROAS by ~0.8x.', 'openai/gpt-4o', 0.91, 'reviewed', 'campaign', 'Shopping – Non-Brand', 'pending'),
  ('a1000000-0000-0000-0000-000000000003', 1, 'creative', 'Scale UGC creative and add stronger CTA overlay on TikTok', 'UGC ad achieved 3x higher CTR than branded video. A direct-response CTA overlay could improve conversion rate from current 0.4%.', 'openai/gpt-4o', 0.83, 'unreviewed', 'campaign', 'TikTok – UGC Ad Set', 'pending');