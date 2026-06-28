# UI Implementation Guide — Ascendra

> **Purpose**: The mandatory workflow for creating or modifying UI screens in Ascendra.

---

## 1. The Reference-First Rule

You must **never** invent a UI layout from scratch unless explicitly told to do so. The design language is already established, and reference materials exist for all major screens.

Before writing any Flutter UI code, you MUST:

1. Identify the screen you are building.
2. Look in the `assets/reference/` directory.
3. Open `assets/reference/<screen_name>/screen.png` to understand the visual target.
4. Open `assets/reference/<screen_name>/code.html` to understand the structural logic (spacing, typography hierarchy, colors).

## 2. Component Extraction

Once you have reviewed the reference, do not immediately start writing a monolithic `build` method.

1. **Identify reusable blocks**: Look at the reference image. What parts could be used elsewhere? (e.g., a member avatar row, a metric card, a status badge).
2. **Check the Catalog**: Look in `docs/COMPONENT_CATALOG.md` and `lib/shared/widgets/`. Does a widget for this already exist?
3. **Build the sub-components**: Create these as separate `StatelessWidget` classes in the feature's `widgets/` folder.
4. **Give them ViewModels**: Pass simple data classes into these components, not complex Riverpod state.

## 3. Responsive Implementation

Ascendra is a mobile-first platform, but leaders frequently use it on tablets and desktop browsers.

### The Mobile-First Approach
1. Build the layout targeting a `360px` width screen (e.g., `mobileSmall`).
2. Ensure there are no overflow errors. Use `Expanded`, `Flexible`, and `Wrap`.
3. Use `ResponsiveBuilder` from `lib/core/responsive/responsive_builder.dart` to adjust the layout for wider screens.

```dart
// Example of responsive adjustment
ResponsiveBuilder(
  mobile: (context) => const Column(children: [ChartA(), ChartB()]),
  tablet: (context) => const Row(children: [Expanded(child: ChartA()), Expanded(child: ChartB())]),
)
```

## 4. Applying the Design System

Do not hardcode colors, spacing, or fonts. Translate the reference HTML/CSS into Ascendra's Flutter tokens.

| Reference CSS / HTML | Flutter Translation |
|----------------------|---------------------|
| `color: #181e1a` | `AppColors.primary` |
| `background-color: #fcf9f7` | `AppColors.background` |
| `padding: 16px` | `padding: EdgeInsets.all(AppSpacing.md)` |
| `border-radius: 8px` | `borderRadius: BorderRadius.circular(AppRadius.md)` |
| `font-size: 24px, font-weight: 600` | `style: AppTypography.h2` |

See `docs/DESIGN_SYSTEM.md` for the full token list.

## 5. Wiring to Data

Once the UI is built and matches the reference, wire it to the backend.

1. Replace mock ViewModels with `ref.watch(yourProvider)`.
2. Wrap the UI in the provider's `.when()` method to handle loading and error states.
3. Use `LoadingWidgets` and `ErrorWidgets` from `lib/shared/widgets/` for consistent states.
