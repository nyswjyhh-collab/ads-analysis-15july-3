# Tasks & Sprints

## Sprint 1 – DB, Upload Engine & Core Analysis
**Goal:** End-to-end: upload a CSV → metrics extracted → AI insights stored → analysis detail page renders. Anonymous users can see everything.

- [ ] Run migration SQL; verify all tables exist and seed rows appear in Supabase
- [ ] Build `/upload` page: drag-and-drop zone, file type/size validation, error state
- [ ] `/api/upload` route: parse CSV/Excel, map platform columns to canonical fields, reject bad files
- [ ] Write extracted rows to `analyses`, `campaigns`, `ad_sets`, `ads`
- [ ] `/api/analyze` route: build structured JSON, call OpenAI, parse response, write AI fields
- [ ] Analysis detail page (`/analysis/[id]`): summary bar, campaign/ad set/ad breakdown tables
- [ ] Loading, empty, error, partial states on upload and analysis pages
- [ ] Seed data renders on `/` and `/analysis/[id]` without login

**Definition of Done:** Upload a real Meta Ads CSV → page shows campaign breakdown with AI summary within 3 minutes. Core tables have correct data. Works with no account.

---

## Sprint 2 – Dashboard, Recommendations & Export ← **v1 functional milestone**
**Goal:** Full user journey complete: dashboard → upload → insights → recommendations → export.

- [ ] `/` dashboard: list of analyses cards (name, platform, date range, ROAS, status)
- [ ] Empty state (no analyses yet) with Upload CTA
- [ ] Recommendations tab on analysis detail: ranked list with category badge and rationale
- [ ] "Apply" / "Dismiss" buttons update recommendation `status` in DB
- [ ] `/api/export/[id]` route: generate PDF from stored analysis data
- [ ] Copy-to-clipboard button for executive summary
- [ ] Mobile-responsive layout on all screens
- [ ] Audit log written on analysis create, recommendation status change, export

**Definition of Done:** Full scenario passes (upload → insights → 3+ recommendations → PDF exported). All buttons persist to DB. Empty/error/loading states present everywhere. Mobile layout verified.

---

## Sprint 3 – Lock It Down
**Goal:** Per-user data isolation before any real user data enters the system.

- [ ] Add Supabase Auth (email + magic link)
- [ ] Login/signup pages; redirect unauthenticated users
- [ ] Populate `user_id` on all writes (`auth.uid()`)
- [ ] Replace permissive RLS with owner-scoped policies on all tables
- [ ] Audit log `user_id` populated from session
- [ ] Storage bucket policy: users access only their own uploaded files
- [ ] Retain seeded demo rows as public showcase (mark `user_id = null`, policy allows read)

**Definition of Done:** User A cannot read User B's analyses. Seeded demo rows still visible to all. No secrets in client bundle.

---

## Gantt (sprint → feature)
```
Sprint 1: DB schema, file upload, CSV parser, AI analysis API, analysis detail page
Sprint 2: Dashboard, recommendations panel, PDF export, clipboard copy, mobile polish
Sprint 3: Auth, per-user RLS, session-scoped audit logs
```
