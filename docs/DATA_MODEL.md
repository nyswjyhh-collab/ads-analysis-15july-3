# Data Model

## analyses
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner; FK added at lock-down |
| name | text | user-facing label |
| platform | text | `meta` \| `google` \| `tiktok` |
| file_name | text | original filename |
| date_range_start / end | date | extracted from file |
| status | text | `pending` `processing` `complete` `error` |
| total_spend / impressions / clicks / conversions | numeric/bigint | |
| overall_ctr / cpc / cpm / cpa / roas | numeric | |
| executive_summary | text | **AI field** |
| executive_summary_source | text | e.g. `openai/gpt-4o` |
| executive_summary_confidence | numeric | 0–1 |
| executive_summary_review_status | text | `unreviewed` \| `reviewed` |

## campaigns / ad_sets / ads
All share the same metric columns as `analyses` (spend, impressions, clicks, conversions, ctr, cpc, cpm, cpa, roas).
Each has `analysis_id` FK + `performance_label` AI field (+ source/confidence/review_status).
`ad_sets` adds `campaign_id` FK; `ads` adds `ad_set_id` FK.

## recommendations
| Field | Type |
|---|---|
| analysis_id | uuid FK |
| priority | integer (1 = highest) |
| category | text (`budget` `creative` `audience` `bidding` `pause`) |
| action_label | text |
| rationale | text — **AI field** + source/confidence/review_status |
| target_entity_type / name | text |
| status | text (`pending` `applied` `dismissed`) |

## audit_logs
`action`, `entity_type`, `entity_id`, `detail jsonb`, `user_id`, `created_at`

## RLS
v1: permissive read+write for all tables (demo-first).
Lock-down sprint: `auth.uid() = user_id` owner policies replace permissive policies.
