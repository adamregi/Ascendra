import '../failures/failure.dart';

sealed class Result<T> {
  const Result();

  /// Map over the result
  R fold<R>(
    R Function(Failure failure) onError,
    R Function(T value) onSuccess,
  ) {
    if (this is Success<T>) {
      return onSuccess((this as Success<T>).value);
    } else if (this is Error<T>) {
      return onError((this as Error<T>).failure);
    }
    throw StateError('Unreachable');
  }

  /// Returns true if the result is a success.
  bool get isSuccess => this is Success<T>;

  /// Returns true if the result is an error.
  bool get isError => this is Error<T>;
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Error<T> extends Result<T> {
  final Failure failure;
  const Error(this.failure);
}
