# RevFlow website

Single-page lead-generation site for RevFlow's real estate system: Growth System $679/mo, All-In System $800/mo. It is one `index.html`, with no build step.

## 1. Lead form → your email

Every application is emailed to **cecillano.dwight@gmail.com** through FormSubmit.co, a free form-to-email service with no account needed.

**One-time activation:** after the site is live, submit the form once yourself. FormSubmit emails you an "Activate Form" link; click it. From then on every lead arrives in your inbox as a table. Check Spam the first time.

Optional extras, in `const CONFIG` near the bottom of `index.html`:

| Setting | What to paste |
| --- | --- |
| `leadWebhook` | A GoHighLevel inbound webhook or n8n Webhook URL, to also push each lead into your CRM |
| `bookingUrl` | Your calendar link, shown after someone submits |
| `planPrice` | Plan price the deal calculator divides by (default 800) |

Each submission includes: name, email, phone, company, business_type, plan, market, ad_budget, message, consent, cta (which button they clicked), page, referrer, utm_* / gclid / fbclid, calc_leads_month, calc_close_rate, calc_profit_per_deal, timezone, and submitted_at.

## 2. Publish on GitHub Pages

1. Create a new public repository on GitHub, for example `revflow-site`.
2. Click **Add file → Upload files**, drag in `index.html`, `.nojekyll` and `README.md`, then click **Commit changes**.
3. Go to **Settings → Pages**. Under **Build and deployment**, set Source to **Deploy from a branch**, Branch to `main`, folder `/ (root)`, then click **Save**.
4. After a minute or two the site is live at `https://<your-username>.github.io/revflow-site/`.

### Custom domain (optional)

In **Settings → Pages → Custom domain**, enter `www.yourdomain.com`. Then, at your domain registrar, add a CNAME record from `www` to `<your-username>.github.io`. Tick **Enforce HTTPS** once it appears.

## 3. Tracking (optional)

The form pushes a `generate_lead` event to `dataLayer` (Google Tag Manager / GA4). It also fires `fbq('track','Lead')` if the Meta Pixel is on the page. Paste your GTM or Pixel snippet inside `<head>`.
