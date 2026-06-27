# Widget Guidelines

## Purpose
Defines how reusable widgets are built.

## Rules
Widgets must:
* Be stateless whenever possible.
* Never call repositories.
* Never execute RPCs.
* Receive typed models.
* Use theme tokens only.
* Support dark mode.
* Support accessibility.

## Widget Template
```text
Widget
│
├── Input Model
├── Callbacks
├── Theme
└── Rendering
```

## Required States
Every reusable widget supports:
* Loading
* Empty
* Error
* Success

## Accessibility
* Semantics
* Screen reader labels
* Decorative icons excluded
* Minimum touch target 48dp

## Naming
* ExecutiveOverviewCard
* LeadershipPipelinePreview
* RiskBadge
* MetricChip
* StatusBadge

## Component Hierarchy
```text
Primitive
↓
Shared Widget
↓
Feature Widget
↓
Page
```
