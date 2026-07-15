# PRD – Ad Performance Analyzer

## Problem
Digital marketers spend hours manually reviewing ad platform exports to find what's working. Insights arrive too late and are buried in spreadsheets. Decisions are made on gut rather than data.

## Target User
Digital marketers, media buyers, agency account managers, and business owners who run paid campaigns on Meta, Google, or TikTok and export CSVs for reporting.

## Core Objects
- **Analysis** – one upload session; owns all extracted data and AI output
- **Campaign** – rolled-up metrics per campaign within an analysis
- **Ad Set** – metrics per ad set (child of campaign)
- **Ad** – metrics per individual ad (child of ad set)
- **Recommendation** – prioritized action tied to an analysis
- **Audit Log** – record of every significant action

## MVP Must-Haves
- [ ] Drag-and-drop CSV/Excel upload with format validation
- [ ] Metric extraction: Spend, Impressions, Clicks, CTR, CPC, CPM, Conversions, CPA, ROAS
- [ ] AI insight generation per analysis, campaign, ad set, and ad
- [ ] Dashboard listing all analyses with top-line metrics
- [ ] Analysis detail: breakdown tables + AI insights per level
- [ ] Recommendations panel ranked by expected business impact
- [ ] Export: PDF report + copy-to-clipboard executive summary
- [ ] All screens visible without login (demo-first)

## Non-Goals (v1)
Live API integrations, auto-sync, scheduled reports, team collaboration, custom dashboards, predictive forecasting, alerts, multi-client management.

## Success Criteria
A user uploads a Meta Ads CSV → the app extracts all nine metrics → AI generates an executive summary and at least three ranked recommendations → the user exports a PDF — all within three minutes, start to finish, with no manual data entry.
