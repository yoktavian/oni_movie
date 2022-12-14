import 'package:flutter/widgets.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

/// abstraction for route and navigation.
/// as you know that flutter still doing their research about navigation things
/// there is navigation 1.0 and 2.0. so with this abstraction our presentation
/// layer don't need to know what kind of navigation version that we used. or
/// if we want to use a 3rd party library for navigation than we just need to
/// adjust the router without touching any screen.
abstract class OniRouter {
  abstract final Map<String, WidgetBuilder> routes;
  abstract ModuleConnector moduleConnector;

  OniRouter() {
    moduleConnector.connect();
  }

  static pushName(
    BuildContext context,
    String route, {
    Map<String, dynamic>? args,
  }) {
    Navigator.of(context).pushNamed(route, arguments: args);
  }

  static pop(
    BuildContext context, {
    Map<String, dynamic>? args,
  }) {
    Navigator.of(context).pop(args);
  }
}
