# RevFlow authentication foundation

This is development-only code. No Supabase project is provisioned or modified by this commit.

1. Use the existing RevFlow project on the Free plan. Do not upgrade or enable paid add-ons.
2. Disable public signups in Authentication settings. Use the dashboard or a trusted server-side admin API to create invited users.
3. Review and apply the SQL migration to the development project. It grants authenticated users read access only to their own active workspace memberships and matching workspaces; anonymous users cannot read either table.
4. Create the first administrator through Supabase Auth, using a verified email and a fresh unique password. Set the membership display name to Joseph and role to admin using trusted administration. Do not put passwords, secret keys, or service-role keys in this public repository.
5. Wire the frontend to the project URL and publishable key, use Supabase Auth email/password or invitation flow, then load the active memberships from the database. A display name is not a login identifier; a username-only flow would require additional design.
6. Before launch, test unauthenticated access, a user with no membership, disabled membership, cross-workspace isolation, password resets, sign-out, and administrator privilege enforcement. Add policies to every future CRM data table before storing real client data.

The live demo remains separate and must not receive real data. This migration establishes only the membership foundation; it does not yet implement full CRM records, frontend authentication, or global admin access.
