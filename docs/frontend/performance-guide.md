# Performance Guide

## Purpose
Frontend performance standards.

## Targets
* **Cold Launch**: <2 seconds
* **Dashboard**: <1 second
* **FPS**: 60 FPS

## Widget Performance
**Avoid:**
* unnecessary rebuilds
* nested FutureBuilders
* large widget trees

**Prefer:**
* const constructors
* ConsumerWidget
* Provider selection
* immutable models

## Images
* WebP
* SVG icons
* Cached assets

## Lists
Use:
* ListView.builder
* Slivers
* Pagination

## Memory
**Avoid:**
* permanent keepAlive
* large caches
* retained controllers

**Dispose:**
* AnimationControllers
* TextEditingControllers
* FocusNodes

## DevTools Checklist
Verify:
* Rebuild counts
* Memory growth
* Shader compilation
* Frame timing
* Network latency

## Release Checklist
Before every release:
* `flutter analyze`
* `flutter test`
* Integration tests pass
* No debug prints
* No TODOs in production code
* Performance targets met
* Accessibility verified
* Physical device validation completed
