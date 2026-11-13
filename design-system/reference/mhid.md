---
name: mhid
description: Material Design Human Interface Design — apply a cross-platform design system that blends Material 3 architecture with Apple HIG minimalism, driven by the MHTS token system and Inverted Emphasis Hierarchy. Use when building or reviewing a cross-platform UI (React, Flutter, SwiftUI, Compose) that must feel polished, content-first, and platform-native.
---

# Material Human Interface Design (MHID)

MHID unifies Google's Material Design 3 (M3) Expressive with Apple's Human Interface Guidelines (HIG): M3's component architecture and motion physics under HIG's strict minimalism and low cognitive load.

## Apply MHID

Apply the system to every interface you build or review:

1. **Tokenize** — express every design decision as an `mh.*` token (reference, system, component). Replace hardcoded hex codes, font sizes, and durations.
   Done when: no hardcoded visual value remains that a token should name.
2. **Map tokens to platform** — resolve each system token to its native visual equivalent (e.g., Apple's transparent "Liquid Glass" materials, a tonal shift elsewhere).
   Done when: every `mh.sys.*` token in use has a stated platform mapping.
3. **Restrain color** — keep 90% of the interface in the reserved neutral palette; spend expressive color only on primary CTAs, selected state, critical status, and data visualization.
   Done when: color appears in no decorative context.
4. **Apply the Inverted Emphasis Hierarchy** — default to Tonal/Outlined buttons for medium-emphasis actions; reserve Filled (solid, +2dp) for one critical, irreversible action per screen; use Text/Icon buttons for supplementary actions.
   Done when: the primary action is the only high-emphasis element on screen.
5. **Check contrast and motion** — text ≥ 4.5:1, graphical elements ≥ 3:1; honor Reduce Motion by falling back to linear/zero-duration opacity changes.
   Done when: every color pair passes WCAG AA and motion tokens degrade under Reduce Motion.

Completion criterion: the interface reads as content-first and polished — tonal elevation instead of heavy shadows, restrained color, token-driven consistency, and full accessibility.

## Design Specification

### Core Principles: The Synthesis Equation

- **Hierarchy: Content First, Structure Second** — the interface is an unobtrusive frame for content. Establish hierarchy through proximity and subtle tonal layering, not aggressive color or heavy shadows.
- **Expressive Subtlety** — limit the visual presence of expressiveness; delegate personality to feedback mechanisms and state transitions via physics-based motion and selective Dynamic Color.
- **Harmonic Consistency** — align with platform conventions (native text rendering, scrolling physics, system behavior). Define the visual identity through the MHID Design Token System (MHTS), not hardcoded styles.

### The MHID Design Token System (MHTS)

Tokens are `name: value` pairs representing repeatable design decisions. Three classes:

| Class | Prefix | Role | Developer Action |
|---|---|---|---|
| Reference | `mh.ref` | Static foundational constants (colors, sizes) | Read-only; defines approved values |
| System | `mh.sys` | Contextual, role-based definitions (primary color, surface) | Required for global properties; resolves per mode (Dark Mode, High Contrast) |
| Component | `mh.comp` | Assigns system tokens to component properties | Required for component styling and state management |

Naming convention: `mh.<class>.<category>.<element>.<state>.<property>` — e.g., `mh.comp.button.primary.hover.color`.

**Token-for-Platform Mapping** is mandatory: system tokens define intent, not fixed implementation. Map `mh.sys.color.surface.elevated` to the platform's native equivalent (transparent/blurred material on Apple; tonal shift or constrained shadow elsewhere), so the app feels native while the semantic role stays consistent.

### Color Palette and Tonal Application

- **Minimalist Color Mandate** — neutral palette for 90% of interface elements (surfaces, backgrounds, primary text). Expressive color is reserved for primary CTAs, selected state, critical status, and data visualization.
- **Dynamic Color (Synthesized Restraint)** — Dynamic Color may only impact `mh.sys.color.primary` and associated tonal surfaces. Text stays fixed, high-contrast, and neutral so legibility is never compromised.
- **Accessibility** — WCAG AA minimums: 4.5:1 for text, 3:1 for graphical elements. Audit every custom `mh.comp` assignment.

| M3 Role | MHID Usage Intent | Constraint |
|---|---|---|
| Primary | High-emphasis CTA; core branding | Maximum one prominent primary action per screen; may be dynamically themed |
| Secondary | Supporting, non-critical actions | Restricted: subtle tonal variant of Primary or a Neutral tone |
| Tertiary | Accents, personality | Prohibited in general interface; only for non-functional illustration or data viz |
| Surface | Backgrounds, containers, cards | Heavily used for elevation hierarchy; must hold contrast with On-Surface tokens |

### Typography and Readability

- **Hierarchical Type Scale** — Display, Headline, Title tiers enforced via `mh.sys.typography` tokens, clearly distinguishing content types.
- **Minimalist Font Strategy** — one primary brand typeface and one system fallback font. Generous line height and ample negative space.
- **Scalability** — the type scale must resize without breaking layout, meeting text-accommodation accessibility requirements.

### Shape and Form

- **Unified Geometry** — consistent, subtle corner-radius scale across all components; no excessive rounding or irregular variation.
- **Tokenized Shape Scale** — constrained radii (`mh.shape.corner.s`, `mh.shape.corner.m`, `mh.shape.corner.l`). Full circularity is reserved for high-emphasis components like the FAB.

### Spatial Language: Purposeful Tonal Layering

- Depth is revealed through light and tone, not aggressive physical stacking.
- Elevation follows the M3 six-level system but is constrained: at rest, only `elev.level.0`–`2`; levels +3–+5 reserved for focus, interaction, and transient elements.
- Shadows are smaller and sharper — subtle lift, not thick layer separation.

| MHID Token | Primary Visual Depiction | Usage Mandate |
|---|---|---|
| `elev.level.0` (0dp) | Base surface color (neutral) | Background, stationary content |
| `elev.level.1` (+1dp) | Subtle tonal shift (+2%) | Static toolbars, cards at rest |
| `elev.level.2` (+2dp) | Moderate tonal shift (+4%) | Elevated buttons, modals, primary nav rail |
| `elev.level.3` (+4dp) | Strong tonal shift (+6%) | Hover/focus states, context menus |
| `elev.level.4` (+5dp) | Distinct tonal shift + scrim | Dialogs, system alerts, draggable elements |

### Motion: Fast, Fluid, Functional

- Use M3 Expressive curves (fluidity) with shorter durations (efficiency).

| Transition | MHID Easing Token | Duration | Alignment |
|---|---|---|---|
| Screen Entry (Decelerate) | `mh.motion.easing.enter` | 250ms | Seamless guidance |
| Screen Exit (Accelerate) | `mh.motion.easing.exit` | 150ms | Rapid, non-distracting dismissal |
| Component Feedback | `mh.motion.easing.expressive` | 200ms | Immediate, substantial feel |
| Full System Transition | `mh.motion.easing.spatial` | 350ms | Reinforce spatial relationships |

- **Reduce Motion is mandatory** — when active, motion tokens default to linear or zero-duration opacity changes. Motion is never the sole channel for critical information.

### Component Specifications

#### Action Components (Buttons) — Inverted Emphasis Hierarchy

| MHID Emphasis | M3 Component | Visual Style | Usage Mandate |
|---|---|---|---|
| High | Filled Button | Minimal radius, +2dp elevation | Only critical, irreversible actions; max one per screen |
| Medium (Default) | Tonal or Outlined Button | Subtle tonal fill or outline, +1dp | Primary action for standard tasks |
| Low | Text or Icon Button | No fill, no elevation (0dp) | Supplementary, optional actions |

#### Navigation Patterns

- **Mobile/Small Viewports**: Bottom Navigation Bar (M3), five or fewer core functions.
- **Tablet/Desktop/Wide**: vertical Navigation Rail on the leading edge using `mh.sys.elevation.level.1`.
- **Contextual Navigation**: prefer the minimalist Segmented Control for secondary in-app navigation when options are limited.

### Accessibility Standards

- **Perceivable** — semantic markup for screen readers, comprehensive alt text, tokenized contrast per Section 3.1.3.
- **Operable** — full keyboard navigation; visible, high-contrast focus indicators that override M3's subtle tonal focus defaults.

### Cross-Platform and Future Readiness

- **Toolkit Recommendation** — prefer frameworks with native M3 component and token support: Flutter, Jetpack Compose, SwiftUI.
- **Spatial UI** — tonal elevation and subtle materials translate to dynamic 3D layouts by remapping `mh.sys.elevation` reference values, keeping MHID ready for AR/VR/Foldables.
