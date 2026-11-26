# RevFlow CRM foundation

## Existing system
Public static marketing site (index.html); README documents FormSubmit email delivery and optional webhook. Keep production main unchanged. Live delivery and webhook configuration require verification.

## Proposed architecture
Separate authenticated CRM frontend and managed PostgreSQL backend. Provider selection pending. No customer data or secrets in this public repository. Server-side authorization on every operation; deny anonymous access; owner-only initial workspace; invite-only future users. Require MFA for owner where supported.

## Data model
Workspace, membership, company, contact, lead, source evidence, activity, task, opportunity, consent/suppression record, import run and audit event. All business records scoped to workspace. Unique normalized source IDs and import idempotency keys; preserve source links and verification dates. Phone verification means publicly corroborated, not necessarily test-called.

## Pipeline
New → Attempted → Connected → Qualified → Appointment → Proposal → Won/Lost; nurture separately. Log calls, outcomes and next action. Do not automatically contact prospects until outreach rules and suppression checks are configured.

## Milestones
1. Audit and select backend; implement authentication and database policies. Test anonymous denial, cross-workspace denial, owner access and secret handling.
2. Build lead list, pipeline and activity logging; test CRUD and validation.
3. Import Google Sheets with dry-run, deduplication, error reporting and retry safety. Preserve existing 8 AM lead automation.
4. Client onboarding, VA operations, finance and automation health.

## Release gates
No production deployment until authentication, access policies, backup/recovery and integration tests pass. Use synthetic records for testing. Report completed work, tests, blockers and next milestone at each check-in.
