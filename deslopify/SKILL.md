---
name: deslopify
description: "Deslop web, mobile, and backend apps: eliminate AI-generated slop, speculative features, micro-sliders, fake drag canvases, blocking modals, dead wires, and clutter, making code simpler and maintainable. Use when the user asks to destuffify, de-slop, clean up AI slop, simplify the UI, cut feature bloat, or productionize the app."
---

# Deslop: Productionizing AI-Bloated Apps

A skill to transform bloated, AI-generated prototypes into confident, production-grade applications across any programming language and framework. It eliminates speculative complexity, dead controls, and visual noise while preserving true power through progressive disclosure, leaving all code easier to read, test, and maintain.

**Core Law**: AI coding assistants naturally produce speculative complexity—fake canvases, micro-sliders, redundant button clusters, and blocking modals that real humans find exhausting. Production software is minimal, deterministic, and respects user attention.

## Leading Words

- **Ruthless Subtraction**: Deleting code is the primary lever. When in doubt, delete it. If a user genuinely needs a deleted feature, they will ask for it back; they will rarely ask you to remove a feature you left behind.
- **Dead Wire**: A control, route, or endpoint bound to a dummy handler, placeholder alert, unpersisted local state, broken link, or silent backend failure.
- **Fake Canvas**: An over-engineered cluster of micro-sliders (coordinates, padding, border radiuses, scale offsets, drag handlers) stuffed into what should be a standard responsive component.
- **Blocking Tax**: Any modal, alert dialog, or blocking spinner that interrupts a high-frequency user workflow (such as item creation, quick-edits, scanning, or bulk entry).
- **Progressive Disclosure**: The 80% primary task is fast and clean on first load. Deep power tools live inside collapsed, titled accordions, drawers, or tabs with live summary badges.
- **Code Hygiene**: Leaving the codebase structurally simpler than you found it. Decomposing monoliths into focused subcomponents, enforcing single sources of truth, using strict typed contracts, and retiring speculative abstractions in favor of language and platform standards.
- **Verification Gate**: The non-negotiable rule that every deletion and refactor must pass native static analysis, test suites, and production builds with zero errors.

## The 6-Phase Execution Sequence

### Phase 1: Reconnaissance & Surface Partitioning
Divide the application into 3 to 6 logical domains (e.g., Shell & Navigation, Primary Workflows, Ingestion & Inputs, Detail & Dashboard Views, Settings & Integrations).

Audit each domain thoroughly to hunt:
1. Competing top-level navigation items and button clusters.
2. Fake canvas micro-sliders and raw drag coordinate math.
3. High-frequency workflows interrupted by blocking modals.
4. Speculative features that serve hypothetical edge cases instead of real user workflows.

**Completion Criterion**: An exhaustive subtraction ledger listing every target file, line number range, the specific slop identified, and the proposed simplified replacement.

### Phase 2: The Dead Wire Hunt
Inspect the codebase forensically for disconnected or broken controls:
1. Search for dummy click handlers, placeholder alerts, or inputs/buttons modifying local component state that never syncs to backend persistence, APIs, or database mutations.
2. Search for dead navigation links (placeholder anchors, unrouted paths, mismatched slugs).
3. Search for silent mutation failures: network or database calls that swallow errors without user-facing status indicators, toasts, or error boundaries.
4. Check for state conflicts: settings or toggles that clobber each other or reset when switching views.

**Completion Criterion**: Every dead wire is either fully connected to live persistence or completely removed from the UI. No placeholder scaffolding remains.

### Phase 3: Ruthless Subtraction
Execute removals aggressively across the ledger:
1. **Prune the Navigation Shell**: Reduce top-level sidebars and headers to 3–5 core destinations. Move secondary sub-features (like API keys, advanced filters, or configurations) into their contextual parent views. Add redirect routes for deprecated URLs.
2. **Consolidate Competing Actions**: Merge separate creation triggers (e.g., separate buttons for each sub-entity) into a single primary action with an internal segmented toggle or selector.
3. **Eliminate the Blocking Tax**: Replace full-screen blocking modals and modal alerts on high-frequency actions with sleek, auto-dismissing toast notifications (1.0–1.5s delay) or optimistic inline updates.
4. **Smart Single Inputs**: Replace multi-tab input selectors with a single smart input that detects input type automatically via simple pattern detection or heuristics.
5. **Delete Fake Canvas Editors**: Strip out custom coordinate sliders, zoom widgets, and manual drag coordinate math on components that should be responsive, semantic elements. Replace with deterministic layouts and clean presets.
6. **Purge AI Meta-Slop**: Remove speculative AI features that evaluate, rewrite, grade, or gatekeep user-authored input. The user is the author; AI belongs in backend analysis, parsing, or sorting when explicitly requested.

Consult [`reference/anti-patterns.md`](reference/anti-patterns.md) for detailed diagnostics on each pattern before refactoring.

**Completion Criterion**: Net code subtraction across the touched files (typically hundreds to thousands of lines deleted) with zero loss of core functionality.

### Phase 4: Progressive Disclosure Restoration
When an app requires legitimate depth and customization (e.g., visual builders, advanced query filters, theme engines, export pipelines):
1. **Tier 1 (Fast Default Flow)**: Ensure first-time or casual users can achieve the primary outcome in under 15 seconds without opening a single configuration panel.
2. **Tier 2 & 3 (Collapsible Studio Accordions / Drawers)**: Tuck deep controls into collapsible accordion panels, side sheets, or drawer tabs. Keep them collapsed by default.
3. **Live Summary Badges**: Display current values directly on the collapsed header so users see what is active without clicking.
4. **Deterministic Responsive Layouts**: Use calculated proportions and standard responsive layout systems rather than freehand mouse dragging to avoid clipping, overflow, and coordinate breakage.
5. **Automated Guardrails**: Add automated safety checks where customization could cause failure (e.g., contrast verification for color overrides, dimension validation, schema verification).

**Completion Criterion**: The feature provides advanced, pro-tier capabilities while maintaining a clean, uncluttered default interface.

### Phase 5: Code Maintainability & Architecture Hygiene
Do not stop at visual cleanup; refactor the underlying code to be radically easier to read, modify, and maintain:
1. **Decompose Monoliths (< 300 Lines Rule)**:
   - Break apart bloated files, components, or classes into small, single-responsibility units (strictly aiming for under 250–300 lines each). A file or class should do one thing well.
2. **Enforce Single Source of Truth**:
   - Extract duplicated constants, magic numbers, status mappings, enums, color palettes, and schemas out of inline callers into shared, authoritative domain modules.
3. **Strict Type Contracts (No Escape Hatches)**:
   - Eliminate loose escape-hatch types and untyped dictionaries in public boundaries and function signatures.
   - Define explicit, strict types, structs, records, or interfaces for all public function signatures, component props, and API boundaries.
4. **Push State Down**:
   - Remove unnecessary global state. Keep state local to the smallest subtree, function, or lifecycle scope that needs it; avoid shared mutable singletons unless strictly required.
5. **Retire Speculative Abstractions (YAGNI & Platform-First)**:
   - Delete "just in case" helper wrappers, unused generic factories, and dead boilerplate.
   - Reach for the language's standard library and native platform APIs before pulling in external dependencies or inventing custom abstraction layers.
6. **Purge Dead Artifacts**:
   - Remove unused imports, dead mock data, orphaned utility files, uncalled functions, and commented-out code blocks.

**Completion Criterion**: No source file exceeds ~300 lines without clear architectural justification. Zero unused imports or dead utility files remain. All public boundaries have explicit typed contracts.

### Phase 6: Verification Gate & Atomic Commits
Never leave a desloped codebase in a broken state. Run full verification before committing:
1. **Static Analysis & Type Gate**: Run the project's static analyzer, linter, or typechecker. Must produce zero errors or warnings.
2. **Automated Test Suite Gate**: Run the project's automated test suite to ensure all unit, integration, and regression tests pass.
3. **Production Build Gate**: Run the project's production build or packaging command to confirm the release artifact compiles and bundles cleanly.
4. **Atomic Commit**: Commit with a clear, quantified summary of deleted bloat, streamlined routes, and reinforced features.

**Completion Criterion**: Working tree clean, zero static analysis errors, zero test failures, and a clean production build.
