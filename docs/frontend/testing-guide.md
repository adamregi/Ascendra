# Testing Guide

## Purpose
Testing strategy.

## Pyramid
```text
Integration
Widget
Repository
Unit
```

## Repository Tests
Test:
* Success
* Timeout
* Unauthorized
* Malformed JSON
* Empty response

## Provider Tests
Test:
* Loading
* Success
* Error
* Cache expiry
* Retry

## Widget Tests
Every widget verifies:
* Loading
* Empty
* Error
* Success

## Integration Tests
* Authentication
* Dashboard
* Navigation
* Bootstrap
* Role Guards

## Golden Tests
Recommended for:
* Dashboard
* Login
* Cards
* Dialogs

## Device Testing
Test:
* OPPO CPH2491

Validate:
* Dark mode
* Rotation
* Offline
* Resume
* Text scaling
