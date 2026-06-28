# Responsive Guidelines — Ascendra

> **Purpose**: Ascendra's breakpoints and utilities for creating layouts that work on mobile, tablet, and desktop.

---

## 1. Breakpoints

Ascendra defines standard breakpoints in `lib/core/responsive/responsive_breakpoints.dart`.

| Name | Width | Target Devices |
|------|-------|----------------|
| `mobileSmall` | < 390px | iPhone SE, older Androids |
| `mobileMedium` | 390px - 413px | iPhone 12/13/14, standard Androids |
| `mobileLarge` | 414px - 767px | iPhone Max/Plus models |
| `tabletSmall` | 768px - 1023px | iPad Mini, standard iPads (Portrait) |
| `tabletLarge` | 1024px - 1279px | iPad Pro, standard iPads (Landscape) |
| `desktop` | $\ge$ 1280px | Laptops, Desktop monitors |

## 2. The Golden Rule

**Every screen must work at 360px without horizontal overflow.**

Always test your layouts against the `mobileSmall` constraint. If text wraps awkwardly or content overflows, use `Flexible`, `Expanded`, or adjust font sizes based on screen width.

## 3. Responsive Utilities

Ascendra provides several utilities in `lib/core/responsive/` to make building responsive layouts easier.

### `ResponsiveBuilder`

Use this when the actual widget structure needs to change based on the screen size (e.g., turning a Column into a Row).

```dart
ResponsiveBuilder(
  mobile: (context) => const Column(
    children: [SidebarWidget(), MainContentWidget()],
  ),
  tablet: (context) => const Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 250, child: SidebarWidget()),
      Expanded(child: MainContentWidget()),
    ],
  ),
  desktop: (context) => const Row( // Falls back to tablet if not provided
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(width: 300, child: SidebarWidget()),
      Expanded(child: MainContentWidget()),
    ],
  ),
)
```

### `ResponsivePadding`

Use this to automatically adjust outer page margins based on the screen size.

```dart
// Automatically applies 16px on mobile, 24px on tablet, 32px on desktop
ResponsivePadding(
  child: Column(
    children: [ ... ],
  ),
)
```

### `ResponsiveGrid`

Use this for rendering lists of items (like KPI cards or member avatars) that should change column counts dynamically.

```dart
ResponsiveGrid(
  crossAxisSpacing: AppSpacing.md,
  mainAxisSpacing: AppSpacing.md,
  mobileCrossAxisCount: 1, // 1 card per row
  tabletCrossAxisCount: 2, // 2 cards per row
  desktopCrossAxisCount: 4, // 4 cards per row
  children: [
    KpiCard(), KpiCard(), KpiCard(), KpiCard()
  ],
)
```

## 4. Best Practices

- **Avoid fixed widths**: Never use `width: 300` unless it's within a responsive builder that guarantees the screen is wide enough. Use `Expanded` or percentages (`MediaQuery.of(context).size.width * 0.8`).
- **Use Wrap for Chips/Tags**: Instead of a horizontal `Row` which might overflow, use `Wrap` with spacing.
- **Constrain max width on Desktop**: For text-heavy pages, constrain the maximum width (e.g., 800px) and center the content so lines don't become unreadably long on a 4K monitor.
