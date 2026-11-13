---
name: encase
description: The JEMO CORE design language for the web — absolute black/white contrast, hard containment borders, uppercase structural labels. Use when building or styling any web UI (landing pages, dashboards, modals, buttons, forms) and when formatting plan HTML for the plan CLI. Proactively apply when a new interface or plan page needs a visual system.
---

# Encase

Encase is the JEMO CORE design system: absolute contrast, industrial containment, and tactical clarity. It is the style source for plan pages produced by the planner skill.

## Apply Encase

Apply the system to every element and plan page you build:

1. **Crate the layout** — work in the monochrome system: black fills, white text, white borders.
   Done when: every structural and interactive element carries a high-contrast border (black gets white, white gets black).
2. **Set the type voice** — structural text (nav items, button labels, modal headers) is UPPERCASE and BOLD; body copy is sentence case.
   Done when: no structural label is sentence case and no body copy is uppercase.
3. **Contain the geometry** — consistent 8–12px corner radius on containers; no pill shapes for large containers; tight padding inside, generous margins outside.
   Done when: every container radius is within 8–12px and no large container is pill-shaped.
4. **Weight the icons** — filled or heavy-stroke glyphs only; no thin-line icons.
   Done when: no thin-line icon remains in the output.

Completion criterion: the element or page reads as heavy, reliable, and unapologetic — binary contrast, hard containment, softened industrial geometry.

## Design Specification

### Core Philosophy: "The Tactical Monolith"

Three pillars:

- **Binary Contrast** — if it's not Black (#000000), it's White (#FFFFFF). Gray is a utility, not a personality.
- **Hard Containment** — every element lives in a defined space. Use thick, deliberate borders to "crate" information, not whitespace alone.
- **Softened Industrial** — harsh contrast, approachable geometry. Consistent rounded corners prevent the interface from feeling aggressive or sharp.

### Visual Specifications

#### A. The "Onyx" Palette

Monochromatic. Color is reserved for content (images), never for structure.

- True Black (Component Fill): #000000. Navbars, Sidebars, Modals, Primary Buttons.
- Stark White (Text/Borders): #FFFFFF. Text on black backgrounds and the defining 2px–3px borders.

#### B. Typography: "Loud & Clear"

- Headers & Labels: all structural text (Nav items, Button labels, Modal headers) is UPPERCASE and BOLD.
- Body Copy: sentence case, reserved strictly for user feedback and descriptions (e.g., modal body text).
- Font Family: a geometric Sans-Serif (Montserrat, Roboto, or similar) that stays legible at high weights.

#### C. The "Container" Rule (Borders & Radius)

- Borders are Mandatory: every interactive component (Nav, Sidebar, Buttons, Inputs) must have a high-contrast border.
  - Black components get White borders.
  - White components get Black borders.
- Corner Radius: medium radius (~8px to 12px). Large enough to feel friendly, small enough to keep structural integrity. No pill shapes for large containers.

### Component Taxonomy

#### Navigation (The "Command Center")

The Navbar and Sidebar are control panels, not lists of links.

- State: active states use high-contrast inversion (e.g., the "HOME" tab uses a dark grey/lighter black fill to show depth).
- Branding: the JEMO LIFE logo is always prominent, encased in its own "plaque."
- Actions (Buttons):
  - Primary Action: Solid Black Fill + White Text + White Border (high prominence).
  - Secondary Action: White Fill + Black Text + Black Border (alternate path).
  - Destructive/Cancel: White Fill + Black Text + Thick Borders.

#### Feedback (Modals & Alerts)

- Modals: interruptive — a massive black header bar takes over the screen. "CONFIRM ACTION?" text is intentionally oversized to prevent user error.
- Toasts/Alerts: floating black tiles with white iconography. They look like physical "stickers" applied to the screen.

### Implementation Directives

- Icons: filled or heavy-stroke glyphs. No thin-line icons; they must match the weight of the typography.
- Spacing: tight padding inside containers, generous margins outside. The components are heavy; give them room to breathe.