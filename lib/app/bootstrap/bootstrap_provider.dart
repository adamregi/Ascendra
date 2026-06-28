import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/providers/auth_state_provider.dart';
import '../../features/profile/providers/profile_provider.dart';
import '../../features/dashboard/providers/dashboard_providers.dart';

part 'bootstrap_provider.g.dart';

enum BootstrapState {
  initializing,
  unauthenticated,
  fetchingProfile,
  unauthorizedRole,
  ready,
}

@riverpod
class Bootstrap extends _$Bootstrap {
  @override
  BootstrapState build() {
    _initialize();
    return BootstrapState.initializing;
  }

  void _initialize() {
    ref.listen(authStateProvider, (previous, next) async {
      final authState = next.value;

      if (authState == null || authState.session == null) {
        state = BootstrapState.unauthenticated;
        return;
      }

      state = BootstrapState.fetchingProfile;

      try {
        final profile = await ref.read(profileProvider.future);
        if (profile == null) {
          state = BootstrapState.unauthenticated;
          return;
        }

        if (profile.role != 'leader' && profile.role != 'admin') {
          state = BootstrapState.unauthorizedRole;
          return;
        }

        state = BootstrapState.ready;

        // Start dashboard provider futures (unawaited)
        ref.read(executiveOverviewProvider.future).ignore();
        ref.read(leadershipPipelineProvider.future).ignore();
        ref.read(alertPreviewProvider.future).ignore();
        ref.read(recommendationPreviewProvider.future).ignore();
      } catch (e) {
        state = BootstrapState.unauthenticated;
      }
    });
  }
}
