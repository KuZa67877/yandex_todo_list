import 'package:flutter/material.dart';

class ToDoRouteInformationParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.isEmpty) {
      return const RouteSettings(name: '/');
    }

    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'edit') {
      return const RouteSettings(name: '/edit');
    }

    return const RouteSettings(name: '/');
  }

  @override
  RouteInformation? restoreRouteInformation(RouteSettings configuration) {
    if (configuration.name == '/') {
      return const RouteInformation(location: '/');
    }
    if (configuration.name == '/edit') {
      return const RouteInformation(location: '/edit');
    }
    return null;
  }
}
