---
name: unslop-ui
description: "Refuse LLM-default UI in existing apps. Reuse local tokens and components, ban named AI tells. Use when building, editing, or restyling UI, components, pages, CSS, or Tailwind, and when the user invokes /unslop-ui."
---

# Unslop UI

Cut AI tells from UI. Companion to `unslop`, which owns prose.

Tells adapted from [Nutlope/hallmark](https://github.com/Nutlope/hallmark), MIT. No catalog, themes, or verbs.

## Process

1. Scan the repo for colors, type, components, and the icon library. Use those.
2. If none, copy whatever is already on screen into named tokens in the file you write.
3. If the repo is blank, one type family, one accent, paper and ink. Lock them in that file. Not Inter, Roboto, or Open Sans.
4. Do not restyle the app shell.
5. If this screen has no local pattern, pick a layout from the content. Do not emit hero, three icon cards, and a CTA.
6. Run the tells below.
7. Interactive things you touch get hover, `:focus-visible`, and disabled. Error if that control already has an error path. No preview wrapper.

## Copy

No invented metrics, logos, avatars, quotes, or lorem. A number-shaped hole beats a lie. All other writing goes through `unslop`.

## Critical

1. **Purple-gradient hero.** No purple-to-blue or purple-to-pink hero fill. One accent. Solid surface.
2. **Inter-everywhere.** Do not add Inter, Roboto, or Open Sans. If the repo already uses one, keep it.
3. **3-column feature grid.** Three equal icon-heading-body columns is the default dump. Break the grid, or drop the cards.
4. **Card-in-card.** One containment layer. Nested bordered boxes with no semantic reason go.
5. **Gradient headline.** No `background-clip: text` fill. Solid ink. Emphasis via weight or accent, not italic.
6. **Side-stripe card.** No thick coloured left border. Hairline all around, or none.
7. **Full-viewport centred hero.** No `min-height: 100vh` with one sentence and one CTA. Height follows content. Bias left or right.
8. **Pure black, pure white.** Do not introduce `#000` or `#fff` as a new look. Keep them if the app already uses them. Otherwise tint toward the accent.
9. **Default-attractor sameness.** When there is no local pattern, do not emit the same layout you emit on every blank screen. Hero plus three cards plus CTA is the attractor.
10. **Specimen fall-through.** Numbered left-margin labels, huge serif, asymmetric spans, hairline rules, typographic-only CTA is an editorial specimen. Do not use it unless the product is editorial.
11. **AI nav.** Do not add wordmark-left, Features/Pricing/Docs/Blog, CTA-right, sticky, hairline bottom. If the app already has a nav, leave it.
12. **AI footer.** Do not add Product/Company/Resources/Legal columns plus social row plus copyright. Close the page. If a footer exists, leave it.
13. **Aurora-blob background.** No organic mesh blobs behind type. Solid surface, or cut it.
14. **Floating-orb decoration.** No blurred spheres or drifting circles for depth. Cut them.
15. **Sound-on autoplay.** Hero media is muted, plays inline, has a poster. Sound is a control, not a default.
16. **Lazy-loaded LCP.** The LCP image or video is not `loading="lazy"`. Use `fetchpriority="high"`. Lazy-load below the fold only.

## Major

1. **Bounce and elastic easing.** No bounce-in buttons or wobble-on-hover. Exponential ease-out.
2. **Centred everything.** Do not centre headline, body, and CTA in every section. Bias the layout once.
3. **Italic headers.** Headings are roman. Emphasis via weight, accent, or underline. Italic stays in body copy.
4. **Eyebrow on every section.** Uppercase mono labels above every heading are off. Use them only for real steps or chapters, stacked above the heading, never a tag-left hanging header. Cap at two per page.
5. **Shadow-glow on dark.** No coloured halo `box-shadow` on dark cards. Lift with a lighter surface.
6. **Icon-tile feature card.** Rounded tile, icon-in-a-square, heading, two lines, Learn more. Do not ship that as the unit. Asymmetric, or no icon.
7. **Glassmorphism without purpose.** Frosted panels only when they sit over real content. Not as decoration, not over a gradient.
8. **Hover-only affordances.** Hover that reveals a menu, delete, or crucial tooltip must also work on focus and tap.
9. **Tabular data without tabular-nums.** Prices, dates, and metrics get `font-variant-numeric: tabular-nums`.
10. **Mismatched icon sets.** One icon library, the one already in the repo. If none, pick one and keep it. Do not mix strokes.
11. **AI-illustration look.** No mesh-blob people, Midjourney lighting, or corporate doodle humans. Real photos, simple CSS or SVG, or omit.
12. **Invented metrics.** No "10×", "50,000+ teams", "+47% conversion" unless the user supplied the number. Use a labelled pending block, ask, or drop the stat slot.
13. **Generic emoji as feature icon.** No ✨🚀⚡🔥🎯✅ as the icon. Same library as the rest, a custom SVG, or typography alone.
14. **Re-drawn UI chrome.** No fake browser bars, phone notches, code-window dots, or IDE chrome. Real screenshot, hairline border at most.
15. **Mid-render token improvisation.** After the first colour and font are chosen, every later value goes through a named token. No leftover hex in a hover or focus ring.
16. **Wrap-to-two-lines clickable text.** Buttons, nav links, footer links, breadcrumbs, and CTAs stay one line. Shorten the label or `white-space: nowrap`.
17. **Lottie shortcut.** No LottieFiles checkmark, spinner, or loading-dots pull. CSS or a small SVG.
18. **Three.js for a still object.** If the user cannot move it, it is a photo or an SVG, not a WebGL bundle.
