import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_async_state.freezed.dart';

/// A normalized UI state that abstracts away Riverpod's AsyncValue
/// and custom Result types. It explicitly represents the four core UI states.
@freezed
class AppAsyncState<T> with _$AppAsyncState<T> {
  const factory AppAsyncState.loading() = _Loading;
  const factory AppAsyncState.success(T data) = _Success;
  const factory AppAsyncState.empty() = _Empty;
  const factory AppAsyncState.error(String message, [StackTrace? stackTrace]) =
      _Error;
}
