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
import '../../features/tasks/presentation/pages/tasks_page.dart';
import '../../features/tasks/presentation/pages/task_detail_page.dart';
import '../../features/tasks/presentation/pages/create_task_page.dart';
import '../../features/tasks/presentation/pages/task_followups_page.dart';
import '../../features/alerts/presentation/pages/alerts_page.dart';
import '../../features/ai/presentation/pages/ai_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/dev/presentation/pages/component_gallery_page.dart';
import '../../features/dev/presentation/pages/qa_screen.dart';
import '../../features/members/presentation/pages/member_directory_page.dart';
import '../../features/members/presentation/pages/member_profile_page.dart';
import '../../features/more/presentation/pages/more_page.dart';
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
          // Do not interrupt splash. Splash will navigate itself when the video finishes.
          if (!isSplash && !isLogin) return '/login';
          break;
        case BootstrapState.ready:
          // Do not interrupt splash. Splash will navigate itself when the video finishes.
          if (isLogin) return '/dashboard';
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
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return AppShell(child: child); // The BottomNavigationBar wrapper
        },
        routes: [
          GoRoute(
            path: '/dashboard',
            pageBuilder: (context, state) => CustomTransitionPage(
              key: state.pageKey,
              child: const DashboardPage(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
              transitionDuration: const Duration(milliseconds: 300),
            ),
          ),
          GoRoute(
            path: '/meetings',
            builder: (context, state) => const MeetingsPage(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksPage(),
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
          GoRoute(
            name: 'members',
            path: '/members',
            builder: (context, state) => const MemberDirectoryPage(),
            routes: [
              GoRoute(
                name: 'memberProfile',
                path: ':memberId',
                builder: (context, state) {
                  final id = state.pathParameters['memberId']!;
                  return MemberProfilePage(memberId: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/more',
            builder: (context, state) => const MorePage(),
          ),
        ],
      ),
      GoRoute(
        path: '/dev/components',
        builder: (context, state) => const ComponentGalleryPage(),
      ),
      GoRoute(
        path: '/dev/qa',
        builder: (context, state) => const QaScreen(),
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
      GoRoute(
        path: '/tasks/create',
        builder: (context, state) => const CreateTaskPage(),
      ),
      GoRoute(
        path: '/tasks/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskDetailPage(taskId: id);
        },
      ),
      GoRoute(
        path: '/tasks/:id/followups',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskFollowupsPage(taskId: id);
        },
      ),
    ],
  );
}
