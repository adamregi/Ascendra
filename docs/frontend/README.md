# Frontend Documentation

## Purpose
Central entry point for all frontend documentation.

### Contents
- [Architecture](architecture.md)
- [Design System](design-system.md)
- [Widget Guidelines](widget-guidelines.md)
- [State Management](state-management.md)
- [Testing](testing-guide.md)
- [Performance](performance-guide.md)

## Overview
Ascendra is an enterprise-grade mobile application designed to provide distributors and leaders with real-time analytics, pipeline management, alerts, and AI-driven recommendations.

## Technology Stack
- **Framework**: Flutter
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Code Generation**: Freezed, json_serializable
- **Security**: flutter_secure_storage
- **Backend Service**: Supabase Flutter

## Coding Standards
Please refer to the individual guidelines listed in the contents for specific coding standards regarding widgets, state management, and testing.

## Contribution Workflow
1. Read the Architecture and Guidelines documents.
2. Adhere to the defined Design System tokens.
3. Ensure all tests pass (`flutter test`).
4. Ensure no static analysis errors (`flutter analyze`).
5. Complete device verification before merging to production.
