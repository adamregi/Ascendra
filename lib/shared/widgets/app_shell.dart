import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/responsive/responsive_builder.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile:
          (context, constraints) => Scaffold(
            body: child,
            bottomNavigationBar: NavigationBar(
              selectedIndex: _calculateSelectedIndex(context),
              onDestinationSelected: (index) => _onItemTapped(index, context),
              destinations: _destinations(),
            ),
          ),
      tablet:
          (context, constraints) => Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  selectedIndex: _calculateSelectedIndex(context),
                  onDestinationSelected:
                      (index) => _onItemTapped(index, context),
                  labelType: NavigationRailLabelType.all,
                  destinations: _railDestinations(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            ),
          ),
      desktop:
          (context, constraints) => Scaffold(
            body: Row(
              children: [
                NavigationRail(
                  extended: true,
                  selectedIndex: _calculateSelectedIndex(context),
                  onDestinationSelected:
                      (index) => _onItemTapped(index, context),
                  destinations: _railDestinations(),
                ),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(child: child),
              ],
            ),
          ),
    );
  }

  List<NavigationDestination> _destinations() {
    return const [
      NavigationDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: 'Dashboard',
      ),
      NavigationDestination(
        icon: Icon(Icons.event_seat_outlined),
        selectedIcon: Icon(Icons.event_seat),
        label: 'Meetings',
      ),
      NavigationDestination(
        icon: Icon(Icons.task_alt_outlined),
        selectedIcon: Icon(Icons.task_alt),
        label: 'Tasks',
      ),
      NavigationDestination(
        icon: Icon(Icons.menu),
        selectedIcon: Icon(Icons.menu),
        label: 'More',
      ),
    ];
  }

  List<NavigationRailDestination> _railDestinations() {
    return const [
      NavigationRailDestination(
        icon: Icon(Icons.dashboard_outlined),
        selectedIcon: Icon(Icons.dashboard),
        label: Text('Dashboard'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.event_seat_outlined),
        selectedIcon: Icon(Icons.event_seat),
        label: Text('Meetings'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.task_alt_outlined),
        selectedIcon: Icon(Icons.task_alt),
        label: Text('Tasks'),
      ),
      NavigationRailDestination(
        icon: Icon(Icons.menu),
        selectedIcon: Icon(Icons.menu),
        label: Text('More'),
      ),
    ];
  }

  static bool _isMoreRoute(String location) {
    return location.startsWith('/members') ||
        location.startsWith('/alerts') ||
        location.startsWith('/settings') ||
        location.startsWith('/ai') ||
        location.startsWith('/more');
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/dashboard')) return 0;
    if (location.startsWith('/meetings')) return 1;
    if (location.startsWith('/tasks')) return 2;
    if (_isMoreRoute(location)) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/meetings');
        break;
      case 2:
        context.go('/tasks');
        break;
      case 3:
        context.go('/more');
        break;
    }
  }
}
