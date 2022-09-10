import 'package:api_client/api_client.dart';
import 'package:feature_home/feature_home.dart';
import 'package:feature_search/feature_search.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_api/oni_api.dart';
import 'package:oni_router/oni_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

void main() async {
  final serviceLocator = OniServiceLocatorImpl();
  await _initializeServiceFactory(serviceLocator);

  runApp(OniMovieApp(serviceLocator));
}

Future<void> _initializeServiceFactory(
  OniServiceLocator serviceLocator,
) async {
  serviceLocator.registerFactory<OniApi>(
    () => ApiClient(),
  );
}

class OniMovieApp extends StatelessWidget {
  final OniServiceLocator serviceLocator;

  const OniMovieApp(this.serviceLocator, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie List',
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
