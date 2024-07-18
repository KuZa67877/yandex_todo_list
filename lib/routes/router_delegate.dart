import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../core/domain/entities/task.dart';
import '../features/change_task/presentation/screens/change_task_screen.dart';
import '../features/home/presentation/screens/home.dart';

class ToDoRouterDelegate extends RouterDelegate<RouteSettings>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<RouteSettings> {
  final GlobalKey<NavigatorState> navigatorKey;

  ToDoRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  RouteSettings? _currentConfiguration;

  @override
  RouteSettings? get currentConfiguration => _currentConfiguration;

  void _setNewRoutePath(RouteSettings configuration) {
    _currentConfiguration = configuration;
    notifyListeners();
  }

  @override
  Future<void> setNewRoutePath(RouteSettings configuration) {
    _setNewRoutePath(configuration);
    return SynchronousFuture(null);
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(child: ToDoMainScreen()),
        if (_currentConfiguration?.name == '/edit')
          MaterialPage(
              child: ChangeTaskScreen(
                  task: _currentConfiguration?.arguments as Task?)),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _setNewRoutePath(RouteSettings(name: '/'));
        return true;
      },
    );
  }

  void addTask() {
    _setNewRoutePath(RouteSettings(name: '/edit'));
  }

  void editTask(Task task) {
    _setNewRoutePath(RouteSettings(name: '/edit', arguments: task));
  }
}
