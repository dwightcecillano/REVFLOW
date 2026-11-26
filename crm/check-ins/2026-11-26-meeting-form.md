# Meeting request form · November 26, 2026

Tested the actual lead capture handler from the homepage draft (index.html blob cc4d3007d74f00600b44c560a73939a192bbd4e4) with synthetic input in Node, using simulated DOM elements and provider responses.

| Scenario | Observed | Result |
|---|---|---|
| Consent unchecked | No delivery request, consent message shown | Pass |
| Provider rejection | Input retained and submit re-enabled | Pass |
| Retry with provider success | Confirmation displayed | Pass |
| Second click during pending submit | No extra provider request | Pass |
| Scheduler URL empty | Instant booking link hidden | Pass |

Next checks: phone and desktop browser flow, test inbox receipt, exactly-once CRM capture across separate retries, and a private calendar invitation. These isolated tests did not send mail or exercise the live CRM.
