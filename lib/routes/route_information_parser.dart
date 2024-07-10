import 'package:flutter/material.dart';

class ToDoRouteInformationParser extends RouteInformationParser<RouteSettings> {
  @override
  Future<RouteSettings> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);

    if (uri.pathSegments.isEmpty) {
      return RouteSettings(name: '/');
    }

    if (uri.pathSegments.length == 1 && uri.pathSegments[0] == 'edit') {
      return RouteSettings(name: '/edit');
    }

    return RouteSettings(name: '/');
  }

  @override
  RouteInformation? restoreRouteInformation(RouteSettings configuration) {
    if (configuration.name == '/') {
      return RouteInformation(location: '/');
    }
    if (configuration.name == '/edit') {
      return RouteInformation(location: '/edit');
    }
    return null;
  }
}
