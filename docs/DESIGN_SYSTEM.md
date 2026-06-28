# Design System — Ascendra

> **Purpose**: The "Serene Modernist" design tokens used throughout Ascendra.

---

## 1. Color Palette (`AppColors`)

Located in `lib/core/constants/app_colors.dart`.

| Token | Hex Value | Purpose |
|-------|-----------|---------|
| `primary` | `#181e1a` | Deep forest. Used for primary text, headers, and primary buttons. |
| `secondary` | `#536257` | Sage green. Used for secondary elements, success states. |
| `tertiary` | `#241a1b` | Dark charcoal. Used for subtle emphasis. |
| `accentWarm` | `#D4AF37` | Warm gold. Used for badges, highlights, and warnings. |
| `error` | `#ba1a1a` | Deep red. Used for destructive actions and errors. |
| `background` | `#fcf9f7` | Warm off-white. The main application background. |
| `surface` | `#ffffff` | Pure white. Used for cards and elevated elements. |
| `surfaceContainerLow` | `#f6f3f1` | Very light grey. Used for subtle backgrounds. |
| `surfaceContainer` | `#f0edec` | Light grey. Used for inputs and inactive states. |
| `surfaceVariant` | `#e5e2e0` | Medium grey. Used for borders and dividers. |
| `onSurface` | `#1c1c1b` | Almost black. Standard text on surface. |
| `onSurfaceVariant` | `#444844` | Dark grey. Secondary text on surface. |
| `borderSubtle` | `#E5E5E0` | Very light border color. |

## 2. Typography (`AppTypography`)

Located in `lib/core/constants/app_typography.dart`.

Ascendra uses three font families:
- **Newsreader**: For large, elegant serif hero headings.
- **Inter**: The primary system sans-serif for headings and UI text.
- **Hanken Grotesk**: For clean, readable body text and small labels.

| Style | Font | Size | Weight | Line Height |
|-------|------|------|--------|-------------|
| `displayLgMobile` | Newsreader | 36px | 600 (SemiBold) | 1.1 |
| `h1` | Inter | 32px | 700 (Bold) | 1.2 |
| `h2` | Inter | 24px | 600 (SemiBold) | 1.2 |
| `h3` | Inter | 20px | 600 (SemiBold) | 1.3 |
| `subtitle1` | Inter | 16px | 500 (Medium) | 1.4 |
| `body1` | Inter | 16px | 400 (Regular) | 1.5 |
| `body2` | Inter | 14px | 400 (Regular) | 1.5 |
| `bodyLg` | Hanken Grotesk | 18px | 400 (Regular) | 1.5 |
| `bodyMd` | Hanken Grotesk | 16px | 400 (Regular) | 1.5 |
| `labelMd` | Hanken Grotesk | 14px | 600 (SemiBold) | 1.2 |
| `labelSm` | Hanken Grotesk | 12px | 500 (Medium) | 1.2 |
| `caption` | Inter | 12px | 400 (Regular) | 1.2 |

## 3. Spacing Scale (`AppSpacing`)

Located in `lib/core/constants/app_spacing.dart`.

| Token | Value | Purpose |
|-------|-------|---------|
| `xs` | 4px | Tight gaps (e.g., between icon and text) |
| `sm` | 8px | Small gaps (e.g., between list items) |
| `md` | 16px | Standard padding (e.g., inside cards, page margins) |
| `lg` | 24px | Section spacing |
| `xl` | 32px | Major section spacing |
| `xxl` | 48px | Massive gaps (e.g., above footers) |

## 4. Border Radius (`AppRadius`)

Located in `lib/core/constants/app_radius.dart`.

| Token | Value | Purpose |
|-------|-------|---------|
| `sm` | 4px | Small elements (checkboxes, tags) |
| `md` | 8px | Interactive elements (buttons, inputs) |
| `lg` | 12px | Structural elements (cards, containers) |
| `xl` | 16px | Large structural elements (dialogs) |
| `xxl` | 24px | Very large elements (bottom sheets) |
| `full` | 9999px | Completely rounded (avatars, pills) |

## 5. Shadows / Elevation

Ascendra prefers a flat, clean aesthetic. Use shadows sparingly, primarily to indicate interactive states (hover/pressed) or z-index separation (modals, sticky headers).

```dart
// Example subtle shadow
BoxShadow(
  color: AppColors.primary.withOpacity(0.05),
  blurRadius: 10,
  offset: const Offset(0, 4),
)
```
