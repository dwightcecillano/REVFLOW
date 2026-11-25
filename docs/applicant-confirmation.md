# Applicant confirmation email — release specification

**Subject:** RevFlow | We're excited to connect with you!

Hi there!

Thank you for taking the time to reach out to RevFlow. We're excited to get to know you and learn more about your business.

We've received your request for a quick intro chat. Our team will personally review your inquiry and reach out within one US business day to discuss your goals, the challenges you're facing, and how we might help you get more time back.

There's no pressure and no obligation. In the meantime, feel free to explore what we do at https://dwightcecillano.github.io/REVFLOW/.

We look forward to connecting with you!

Warm regards,
The RevFlow Team
Revenue • Operations • Technology

## Release conditions

The existing provider explicitly does not support auto-replies for AJAX submissions. Do not enable a browser-only return URL as proof of acceptance. Use a server endpoint with server-side CAPTCHA verification, strict field validation, per-IP and per-recipient abuse protection, deduplication and a durable database record. Keep sender credentials and destination inbox in server-only secrets. Queue a transactional notification to the business inbox and a separately branded welcome message to the applicant, with the subject above. Do not send promotional campaigns or add applicants to marketing lists without separate consent. Preserve the current confirmation animation and ten-second testimonial redirect. Keep scheduling disabled.

The frontend integration is disabled; the server endpoint, email provider, verified sender, database migrations and end-to-end tests are not deployed. Do not publish this branch until all are verified. The current public page still contains the old browser-side form recipient; remove that recipient and the FormSubmit fallback when a verified replacement is operational. The email address may still exist in public Git history.
