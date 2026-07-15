# Intelligence Layer

## Messy Inputs
- CSV column names vary by platform (Meta: `"Campaign name"`, Google: `"Campaign"`, TikTok: `"Campaign Name"`)
- Some exports include summary/total rows that must be excluded
- Date formats, currency symbols, and percentage notation differ
- Missing columns (e.g. no ROAS column) must be computed from available fields

## Auto-Structure Schema (JSON sent to AI)
```json
{
  "platform": "meta",
  "date_range": { "start": "2025-06-01", "end": "2025-06-30" },
  "totals": { "spend": 12400, "impressions": 1820000, "clicks": 36400, "conversions": 410, "roas": 3.8 },
  "campaigns": [
    { "name": "Retargeting – Warm Audience", "spend": 3800, "roas": 6.2, "ctr": 0.04, "cpa": 16.81 },
    { "name": "Prospecting – Lookalike 1%", "spend": 5200, "roas": 2.8, "ctr": 0.015, "cpa": 36.62 }
  ]
}
```

## Events to Track
- File uploaded, parsed successfully, parse failed
- AI analysis started, completed, failed
- Recommendation status changed (applied/dismissed)
- Report exported (PDF/clipboard)

## Rule-Based Scoring (no AI needed)
- ROAS ≥ account average × 1.3 → `top_performer`
- ROAS ≤ account average × 0.7 → `underperformer`
- CTR week-over-week drop ≥ 15% → `creative_fatigue` flag
- CPA > account average × 1.5 → `high_cpa` flag

## What Gets Ranked
Recommendations sorted by `priority` (integer): computed from impact score = (spend_affected / total_spend) × performance_gap_multiplier. AI may adjust priority with rationale.

## v1 vs Later
**v1:** Single-upload analysis, rule-based labels, GPT-4o plain-language summary
**Later:** Date-range comparison, trend detection across multiple uploads, anomaly detection
