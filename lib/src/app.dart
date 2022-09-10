import 'package:entity_config/entity_config.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_search/feature_search.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class OniMovieApp extends StatelessWidget {
  final FlavorConfig config;
  final OniServiceLocator serviceLocator;

  const OniMovieApp(this.config, this.serviceLocator, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
      debugShowCheckedModeBanner: config.mode == Mode.debug,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _populateRoutes(
        [
          HomeRouter(serviceLocator),
          SearchRouter(serviceLocator),
        ],
      ),
      initialRoute: HomeRoutes.home,
    );
  }

  Map<String, Widget Function(BuildContext)> _populateRoutes(
    List<OniRouter> route,
  ) {
    final Map<String, Widget Function(BuildContext)> routes = {};
    for (var router in route) {
      routes.addAll(router.routes);
    }
    return routes;
  }
}
