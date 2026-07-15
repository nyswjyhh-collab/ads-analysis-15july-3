# Security

## Secret Handling
- `OPENAI_API_KEY` and `SUPABASE_SERVICE_ROLE_KEY` live only in Vercel environment variables
- Client uses `SUPABASE_ANON_KEY` only — never the service role key
- All AI calls route through `/api/analyze` server route; the key is never passed to the browser

## Permission Model (v1 → lock-down)
- **v1:** Permissive RLS (`using (true)`) on all tables — demo works without login
- **Lock-down sprint:** Every write populates `user_id = auth.uid()`; RLS replaced with `auth.uid() = user_id`; anonymous reads removed
- Uploaded files stored in a private Supabase Storage bucket; presigned URLs scoped to the owning user at lock-down

## Approved Tools Rule
- Only `parse_csv`, `analyze_with_ai`, and `generate_pdf` may be invoked by server routes
- No `eval`, no dynamic code execution, no raw `run_any` shell access
- AI response is parsed into a fixed schema before any field is written to the DB — the raw LLM string is never executed

## Audit Principle
- Every analysis creation, AI call, recommendation status change, and export writes a row to `audit_logs`
- Audit rows are append-only (no update/delete policy — even at lock-down)
- If a security concern arises around payments, legal data, or data deletion at scale: stop and consult a human before proceeding
