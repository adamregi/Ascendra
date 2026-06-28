import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class LoggerService {
  static void i(String message, {String tag = 'INFO'}) {
    if (kDebugMode) developer.log(message, name: tag);
  }

  static void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
    String tag = 'ERROR',
  }) {
    developer.log(message, name: tag, error: error, stackTrace: stackTrace);
  }

  static void logRpc({
    required String rpcName,
    required Duration duration,
    required bool isSuccess,
    Object? error,
    String? userId,
    String? companyId,
    String? exceptionType,
    String? statusCode,
  }) {
    final status = isSuccess ? 'SUCCESS' : 'FAILED';

    final buffer = StringBuffer();
    buffer.writeln(
      '[$rpcName] completed in ${duration.inMilliseconds}ms ($status)',
    );
    if (userId != null) buffer.writeln('  User: $userId');
    if (companyId != null) buffer.writeln('  Company: $companyId');
    if (exceptionType != null) buffer.writeln('  Exception: $exceptionType');
    if (statusCode != null) buffer.writeln('  Status Code: $statusCode');

    if (isSuccess) {
      i(buffer.toString(), tag: 'RPC');
    } else {
      e(buffer.toString(), error: error, tag: 'RPC');
    }
  }
}
