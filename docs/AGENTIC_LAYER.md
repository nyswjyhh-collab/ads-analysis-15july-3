# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto-execute
- `summarize_analysis`: generate executive summary from structured metrics
- `label_performance`: tag campaigns/ad sets/ads as top_performer / underperformer
- `score_recommendations`: compute priority score for each recommendation
- `extract_metrics`: parse CSV rows into canonical metric fields

### Medium Risk — Show draft, user confirms
- `draft_recommendation`: propose action_label + rationale; user clicks "Apply" to set status = `applied`
- `flag_anomaly`: surface a creative-fatigue or high-CPA warning; user dismisses or acts

### High Risk — Explicit approval always required
- `export_pdf`: generates and serves a PDF — user must click Export button (no auto-send)

### Critical — Human only
- Deleting an analysis (permanent data loss) — requires explicit confirm dialog
- Any future action that sends data to a third-party platform

## Named Tools (v1)
| Tool | Input | Output |
|---|---|---|
| `parse_csv` | raw file buffer, platform hint | structured metrics JSON |
| `analyze_with_ai` | structured metrics JSON | insights + recommendations JSON |
| `generate_pdf` | analysis_id | PDF blob |

## Audit Log Fields
`action`, `entity_type`, `entity_id`, `detail` (JSON: before/after or params), `user_id`, `created_at`

Every `analyze_with_ai` call, every recommendation status change, and every export is logged.

## v1 vs Later
**v1:** Auto-extract, auto-label, draft recommendations, export on demand
**Later:** Agent monitors multiple analyses over time, auto-detects regressions, proposes budget reallocation with one-click approval
