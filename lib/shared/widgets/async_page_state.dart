import 'package:flutter/material.dart';

import '../state/app_async_state.dart';

/// A generic wrapper to handle common asynchronous page states.
/// It seamlessly integrates with [AppAsyncState].
class AsyncPageState<T> extends StatelessWidget {
  final AppAsyncState<T> state;
  final Widget Function() loading;
  final Widget Function(String error, StackTrace? stackTrace) error;
  final Widget Function() empty;
  final Widget Function(T data) builder;

  const AsyncPageState({
    super.key,
    required this.state,
    required this.loading,
    required this.error,
    required this.empty,
    required this.builder,
  });

  @override
  Widget build(BuildContext context) {
    return state.when(
      loading: loading,
      success: builder,
      empty: empty,
      error: error,
    );
  }
}
