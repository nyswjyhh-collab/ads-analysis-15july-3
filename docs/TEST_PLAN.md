# Test Plan

## V1 Success Scenario (manual walkthrough)
1. Open `/` — dashboard shows 3 seeded analysis cards with platform badges and ROAS figures
2. Click "New Analysis" → `/upload` page loads with drag-and-drop zone
3. Drop a valid Meta Ads CSV → progress indicator appears → no error
4. After processing: redirected to `/analysis/[id]`
5. Verify: executive summary text present, campaign breakdown table shows ≥ 1 row with spend/ROAS/CTR
6. Click "Recommendations" tab → at least 3 items listed with priority rank and rationale
7. Click "Apply" on top recommendation → status badge changes to "Applied"; refresh → persists
8. Click "Export PDF" → PDF downloads with executive summary, metrics table, and recommendations
9. Click "Copy Summary" → clipboard contains non-empty text

## Empty States
- Fresh deploy with no user uploads: dashboard shows empty state with Upload CTA (seed rows still visible)
- Upload page with no file selected: Export button disabled

## Error Cases
- Upload a `.txt` file → error message: "Unsupported file type. Please upload a CSV or Excel file."
- Upload a CSV with no recognizable ad metrics columns → error: "Could not extract ad metrics. Check your export format."
- OpenAI call times out → analysis status set to `error`; page shows "AI analysis failed — metric tables still available"
- Navigate to `/analysis/non-existent-id` → 404 message, link back to dashboard

## Data Integrity Checks
- After upload, query `campaigns` table: `sum(spend)` matches `analyses.total_spend`
- Recommendation `priority` values are unique integers starting at 1 within an analysis
- Every AI field has a non-null `_source` and `_confidence` value

## Permissions (post Sprint 3)
- Log in as User A, create an analysis; log in as User B → User B's dashboard shows no User A analyses
- Attempt direct Supabase query as anon for User A's analysis → returns 0 rows
