# Component Catalog — Ascendra

> **Purpose**: A reference guide to the shared reusable widgets available in `lib/shared/widgets/`.

---

## 1. Layout & Structure

### `ResponsivePadding`
- **Description**: Automatically applies `xs`, `md`, or `lg` padding to its child based on the screen width.
- **Usage**: Wrap the main content of every page.

### `AppCard`
- **Description**: A container with the standard border radius, background color (surface), and subtle border/shadow.
- **Usage**: Encapsulating logical groups of data (e.g., a single KPI, a member summary).

### `SectionHeader`
- **Description**: Standard title with an optional trailing widget (like a "View All" button).
- **Usage**: Above lists or grids.

## 2. Forms & Inputs

### `AppTextField`
- **Description**: Standard text input with floating label and error state handling.
- **Usage**: All text inputs. Never use raw `TextFormField`.

### `AppButton`
- **Description**: The primary call-to-action button. Supports loading states.
- **Variants**: `primary`, `secondary`, `outlined`, `text`, `danger`.
- **Usage**: All buttons.

### `AppDropdown<T>`
- **Description**: Standardized dropdown menu.

## 3. Data Display

### `AppAvatar`
- **Description**: Circular image widget with initials fallback and optional online/status indicator.
- **Usage**: Displaying member profile pictures.

### `StatusBadge`
- **Description**: A small rounded rectangle showing a status string with dynamic colors.
- **Usage**: Displaying task statuses, meeting statuses, or compliance states (e.g., Green for Active, Red for Suspended).

### `KpiCard`
- **Description**: Displays a large number, a label, and a trend indicator (arrow up/down).
- **Usage**: Dashboards and Overview tabs.

### `TimelineEventWidget`
- **Description**: A single node in a vertical timeline list (includes the dot, vertical line, and content).
- **Usage**: Member timeline, task history.

## 4. State Handlers

### `LoadingShimmer`
- **Description**: Standard animated skeleton loader.
- **Usage**: Inside the `loading` state of a Riverpod `AsyncValue`.

### `ErrorDisplay`
- **Description**: A user-friendly error message with an optional retry button.
- **Usage**: Inside the `error` state of a Riverpod `AsyncValue`.

### `EmptyStateWidget`
- **Description**: An illustration, text, and optional action button shown when a list is empty.
- **Usage**: e.g., "No tasks assigned yet."
