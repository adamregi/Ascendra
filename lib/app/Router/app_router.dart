import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';

import '../bootstrap/bootstrap_provider.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
// Placeholders
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/meetings/presentation/pages/meetings_page.dart';
import '../../features/meetings/presentation/pages/meeting_detail_page.dart';
import '../../features/meetings/presentation/pages/schedule_meeting_page.dart';
import '../../features/meetings/presentation/pages/live_meeting_page.dart';
import '../../features/meetings/presentation/pages/meeting_replay_page.dart';
import '../../features/alerts/presentation/pages/alerts_page.dart';
import '../../features/ai/presentation/pages/ai_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/dev/presentation/pages/component_gallery_page.dart';
import '../../shared/widgets/app_shell.dart';

part 'app_router.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

@riverpod
GoRouter appRouter(Ref ref) {
  final bootstrapState = ref.watch(bootstrapProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';
      final isLogin = state.matchedLocation == '/login';
      
      switch (bootstrapState) {
        case BootstrapState.initializing:
        case BootstrapState.fetchingProfile:
          if (!isSplash) return '/splash';
          break;
        case BootstrapState.unauthenticated:
        case BootstrapState.unauthorizedRole:
          if (!isLogin) return '/login';
          break;
        case BootstrapState.ready:
          if (isSplash || isLogin) return '/dashboard';
          break;
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child); // The BottomNavigationBar wrapper
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            builder: (context, state) => const DashboardPage(),
          ),
          GoRoute(
            path: '/meetings',
            builder: (context, state) => const MeetingsPage(),
          ),
          GoRoute(
            path: '/alerts',
            builder: (context, state) => const AlertsPage(),
          ),
          GoRoute(
            path: '/ai',
            builder: (context, state) => const AiPage(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => const SettingsPage(),
          ),
        ],
      ),
      GoRoute(
        path: '/dev/components',
        builder: (context, state) => const ComponentGalleryPage(),
      ),
      GoRoute(
        path: '/meetings/schedule',
        builder: (context, state) => const ScheduleMeetingPage(),
      ),
      GoRoute(
        path: '/meetings/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MeetingDetailPage(meetingId: id);
        },
      ),
      GoRoute(
        path: '/meetings/live/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return LiveMeetingPage(meetingId: id);
        },
      ),
      GoRoute(
        path: '/meetings/replay/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return MeetingReplayPage(meetingId: id);
        },
      ),
    ],
  );
}
