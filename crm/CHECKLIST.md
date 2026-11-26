# RevFlow development checklist

Updated November 26, 2026. A checked item means the stated observation was verified. Open items require implementation, testing or a decision.

## Verified foundation

- [x] Located the CRM foundation branch, separate test login portal, authentication development branch and existing isolation test.
- [x] Confirmed the portal source includes sign-in, password setup and recovery, workspace listing, administrator lead creation and stage changes. End-to-end behavior remains open.
- [x] Confirmed row-level security is enabled on the four current CRM tables.

## Next client milestone

An invited client signs in, sees their assigned VA, submits a task and sees the VA's progress. Verify on desktop and mobile with synthetic accounts before inviting a real client.

- [ ] Reconcile the schema used by the existing isolation test with the schema the portal actually queries. Verify admin, two distinct clients, an assigned VA, an unassigned or disabled user and anonymous access in an isolated environment. Check permitted reads and writes as well as denials.
- [ ] Verify administrator invitation creation, role and workspace assignment, delivery, resend, expiry and revocation. Test first password, sign-in, recovery and sign-out.
- [ ] Provide the client and VA workspace views, assigned contact and a clear first action. Correct home navigation and add a verified support route.
- [ ] Implement one task submission, assignment, VA status update and client readback. Verify that refreshing or retrying cannot create a duplicate.
- [ ] Capture actual outcomes and the next blocker in each milestone update.

## Before launch

- [ ] Exercise administrator lead creation, edits and stage history against test records.
- [ ] Verify every public form, intended recipient, inbox delivery, error handling, duplicate-safe CRM capture and mobile confirmation.
- [ ] Exercise client onboarding from discovery and candidate selection through workspace setup and VA assignment.
- [ ] Test failure and recovery paths, mobile navigation, backups, restore and rollback. Obtain owner approval before production deployment.

## Later development

- [ ] Sales pipeline, follow-ups, source evidence, suppression, deduplication and safe tracker imports.
- [ ] Recruitment records, candidate consent, shortlist and interview coordination.
- [ ] Task comments, files, recurring work, deadlines, time entries, attendance and performance reporting.
- [ ] Contracts, invoicing, payroll, billing, subscriptions and authorized financial reporting.
- [ ] Client communications, automation monitoring, analytics and AI integrations after core workflows pass.
