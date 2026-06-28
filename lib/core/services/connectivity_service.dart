import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_service.g.dart';

enum AppConnectionState { online, offline, reconnecting }

@riverpod
Stream<AppConnectionState> connectivityStatus(Ref ref) async* {
  final connectivity = Connectivity();

  // Initial check
  final initialResult = await connectivity.checkConnectivity();
  if (initialResult.contains(ConnectivityResult.none)) {
    yield AppConnectionState.offline;
  } else {
    yield AppConnectionState.online;
  }

  // Stream changes
  await for (final result in connectivity.onConnectivityChanged) {
    if (result.contains(ConnectivityResult.none)) {
      yield AppConnectionState.offline;
    } else {
      yield AppConnectionState.online;
    }
  }
}
