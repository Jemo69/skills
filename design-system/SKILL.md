---
name: design-system
description: Unified UI design router — Encase tactical black/white for web + plan pages, or MHID token-driven minimal for cross-platform apps. Use when building/styling any UI, formatting plan HTML, or reviewing an interface.
---

# Design System — router

One skill, two modes. Pick the branch first, then apply only that branch. Never blend them — Encase's heavy containment and MHID's tonal subtlety cancel each other out.

## 0 - Pick the mode (one sentence, then commit)

- **Encase** → web UI (landing, dashboard, modal, button, form) OR any plan HTML for the plan CLI. Full spec: [reference/encase.md](reference/encase.md).
- **MHID** → cross-platform UI that must feel native (React, Flutter, SwiftUI, Compose) OR any design review/audit. Full spec: [reference/mhid.md](reference/mhid.md).

Default when ambiguous: web/plan page = Encase, native app = MHID. State the pick in one line.

Done when: mode is named and only its reference is loaded.

## 1a - Encase branch (tactical monolith)

Load [reference/encase.md](reference/encase.md) only on this branch.

1. Crate the layout — black fills, white text, 2–3px high-contrast borders on every structural element.
2. Type voice — structural text UPPERCASE+BOLD, body sentence case.
3. Geometry — 8–12px radius, no pill containers, tight-inside / generous-outside spacing.
4. Icons — filled/heavy-stroke only, no thin lines.

Done when: page reads heavy, reliable, unapologetic — binary contrast, hard containment.

## 1b - MHID branch (content-first native)

Load [reference/mhid.md](reference/mhid.md) only on this branch.

1. Tokenize — every visual value as `mh.*` token, zero hardcoded hex.
2. Map to platform — each `mh.sys.*` token gets a native equivalent (Liquid Glass on Apple, tonal shift elsewhere).
3. Restrain color — 90% neutral, color only on primary CTA / selected / critical / data-viz.
4. Inverted emphasis — Tonal/Outlined = default action, Filled (+2dp) = one critical irreversible action max per screen.
5. Contrast + motion — text ≥4.5:1, graphics ≥3:1, Reduce Motion falls back to linear/zero opacity.

Done when: interface reads content-first and polished — tonal elevation, restrained color, token consistency, WCAG AA.

## 2 - Verify (both branches)

- No cross-branch leakage (no `mh.*` tokens in Encase, no hard 3px crates in MHID).
- Re-read the changed surfaces only; unrelated files untouched.

Completion criterion: the mode named in step 0 passes its Done clause, and the other mode's reference was never loaded.
