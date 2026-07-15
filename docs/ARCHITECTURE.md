# Architecture – Ad Performance Analyzer

## Stack
- **Frontend:** Next.js 14 (App Router) + Tailwind CSS
- **Backend/DB:** Supabase (Postgres + Storage for uploaded files)
- **AI:** OpenAI GPT-4o via server-side API route (key never exposed to client)
- **Export:** React-PDF or Puppeteer server route for PDF generation
- **Hosting:** Vercel

## What to Build Now vs Later
**Now:** Upload → parse → store → AI analyze → display → export
**Later:** Auth & per-user isolation, live platform APIs, team workspaces, scheduled runs

## Key User Action — Step-by-Step Flow
1. User drops a CSV on the Upload screen
2. Client validates file type/size; sends to `/api/upload`
3. Server parses rows, maps columns to canonical metric fields, rejects unrecognized formats
4. Parsed metrics written to `analyses`, `campaigns`, `ad_sets`, `ads` tables
5. Server calls OpenAI with a structured prompt; response parsed into insights + recommendations
6. AI fields stored with `_source`, `_confidence`, `_review_status`
7. Analysis detail page fetches from DB and renders breakdown + insights
8. Recommendations ranked by `priority` integer (rule-based score + AI override)
9. Export route renders PDF from stored data (no live AI call needed at export)

## Layer Plan
1. **Data layer first** – tables, constraints, RLS policies
2. **Parse + store** – deterministic metric extraction runs with no AI
3. **App logic** – rule-based performance labeling (top/under-performer thresholds)
4. **Intelligence on top** – AI adds plain-language explanations and ranked recommendations

## Core Without AI
Metric extraction, breakdown tables, and rule-based performance labels all work if the OpenAI call fails. AI fields show `'unreviewed'` status and a placeholder message.
