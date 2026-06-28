# Version Matrix — Ascendra

> **Purpose**: Documents the exact version compatibility matrix for the Ascendra technology stack. AI agents must check this matrix before proposing dependency upgrades.

---

## 1. Core Stack

| Component | Target Version | Min Supported | Upgrade Considerations |
|-----------|----------------|---------------|------------------------|
| **Flutter** | `3.19.0` | `3.16.0` | Ensure `build_runner` and `analyzer` versions remain compatible. |
| **Dart SDK** | `^3.3.0` | `3.2.0` | Riverpod generator requires Dart 3 features. |
| **Riverpod** | `^2.4.9` | `2.4.0` | Breaking changes occur in major bumps (3.x). Lock versions. |
| **Supabase** (Flutter) | `^2.4.0` | `2.0.0` | PostgREST syntax changes frequently in minor versions. |

## 2. Infrastructure

| Component | Target Version | Min Supported | Upgrade Considerations |
|-----------|----------------|---------------|------------------------|
| **PostgreSQL** | `15.x` | `14.x` | Required for `pgvector` HNSW index support. |
| **pgvector** | `0.5.1` | `0.4.0` | HNSW indexes require re-building if upgrading from <0.5.0. |
| **NestJS** | `10.x` | `9.x` | RxJS version alignment is critical for BullMQ. |
| **Deno** (Edge) | `1.38.x` | `1.36.x` | Ensure `std` library imports are updated when bumping. |

## 3. Mobile Deployment Targets

| Platform | Target SDK | Minimum Required | Notes |
|----------|------------|------------------|-------|
| **Android** | `API 34` | `API 24` | 100ms video SDK requires min SDK 24. |
| **iOS** | `iOS 17.0` | `iOS 14.0` | Required for native WebRTC implementations. |

---
*Note: Always run the full automated test suite after bumping any version listed in this matrix.*
