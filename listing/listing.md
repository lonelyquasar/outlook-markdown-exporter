# AppSource listing copy

Paste-ready text for the Partner Center offer (Microsoft 365 and Copilot
program, Office Add-in). Limits are from the Partner Center docs: name 50
characters, summary 100, description 10,000 (keep it well under 4,000; the
docs quote both figures). Description accepts basic HTML.

## Offer name

Copy as Markdown

(Must match `DisplayName` in the manifest. Partner Center may append the
publisher; do not add "for Outlook" here — the product name is shown
alongside it automatically.)

## Summary (100 chars max)

Copy the open email, quoted thread included, as clean Markdown for LLMs, Obsidian, tickets, wikis.

(98 characters.)

## Description

<p>Copy as Markdown converts the email you have open into clean, portable Markdown and puts it on the clipboard with one click. Paste it into an AI assistant, a notes app such as Obsidian, a ticket, a wiki page, or anywhere else plain text is welcome.</p>

<p><b>What you get</b></p>
<ul>
<li>YAML frontmatter with subject, sender, recipients, date, message id and attachment names, so the result is ready for note-taking tools and automation.</li>
<li>The quoted reply chain split into one section per message, titled by sender and date. Outlook, Gmail and Apple Mail quoting styles are all recognized, including deeply nested threads.</li>
<li>Real Markdown for formatting that matters: headings, bold and italic, lists, links and tables. Signature strips and layout tables are unwrapped so their text survives without raw HTML.</li>
<li>Links rewritten by mail security gateways (Microsoft Defender Safe Links and similar) are unwrapped back to the original URL where the target is recoverable.</li>
</ul>

<p><b>Optional clean-up</b></p>
<ul>
<li>Strip signatures, "Sent from my phone" footers, confidentiality disclaimers, social icon rows and tracking pixels.</li>
<li>Replace email addresses with the person's display name, first name, or a stable alias (User1, User2, ...) when you want to share a thread with an AI tool without handing over anyone's address.</li>
</ul>

<p>Your choices are remembered between messages. Converted text can be copied to the clipboard or saved as a .md file.</p>

<p><b>Private by design</b></p>
<p>Everything happens inside the task pane on your device. The add-in reads only the message you have open, sends nothing to any server, and keeps no copy of your mail. There is no account to create, no sign-in, and nothing to buy. See the privacy policy for details.</p>

<p><b>Works in</b> new Outlook for Windows, Outlook on the web, and classic Outlook for Windows and Mac (Mailbox requirement set 1.8 or later).</p>

<p>Copy as Markdown is free and open source (MIT license). Source code, issue tracker and contribution guide: <a href="https://github.com/lonelyquasar/outlook-markdown-exporter">github.com/lonelyquasar/outlook-markdown-exporter</a></p>

## Search keywords

markdown, export email, LLM

## Categories

Productivity (primary). Optionally Collaboration. No industry.

## Legal and support links

| Field | Value |
| --- | --- |
| Support document link | https://lonelyquasar.com/outlook-markdown/ |
| Privacy policy link | https://lonelyquasar.com/outlook-markdown/privacy |
| EULA link | https://lonelyquasar.com/outlook-markdown/terms |

Do not tick "Standard Contract"; it cannot be reversed and we have our own
terms page.

## Product setup answers

| Question | Answer |
| --- | --- |
| Listed in the Apple Store | No |
| Uses Microsoft Entra ID / SSO | No |
| Requires additional purchases | No |
| Lead management CRM | No |

## Images

| Asset | File | Spec |
| --- | --- | --- |
| Store logo | `listing/logo-300.png` | 300 x 300 PNG |
| Screenshot 1 | `listing/listing-light.png` | 1366 x 768, under 1024 KB |
| Screenshot 2 | `listing/listing-dark.png` | 1366 x 768, under 1024 KB |

Screenshot caption (both): "The open message converted to Markdown with
frontmatter and a split reply chain, ready to copy."

## Notes for certification

Copy as Markdown needs no account, sign-in, license key or purchase. It has
no server component.

To test:

1. Open any received email in Outlook (new Outlook for Windows, Outlook on
   the web, or classic Outlook). A message with a quoted reply chain shows
   the most.
2. On the message, choose the "Copy as Markdown" button (new Outlook: the
   "..." overflow menu on the message toolbar, under "Copy as Markdown").
3. The task pane opens and converts the message immediately. The Markdown
   preview appears in the pane.
4. Click "Copy Markdown". The status line reports the number of characters
   copied. Paste into any text editor to confirm.
5. "Save .md" downloads the same text as a file.
6. The four checkboxes (split thread, strip signatures, strip addresses,
   and the address style) re-run the conversion when toggled.

The add-in reads only the open message via Office.js and performs the
conversion in the task pane. No network requests are made other than
loading the task pane's own static files from GitHub Pages.
