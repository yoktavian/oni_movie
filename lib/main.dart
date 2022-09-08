import 'package:feature_auth/feature_auth.dart';
import 'package:feature_home/feature_home.dart';
import 'package:flutter/material.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';

void main() {
  runApp(const OniMovieApp());
}

class OniMovieApp extends StatelessWidget {
  const OniMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: _populateRoutes(
        [
          AuthRouter(),
          HomeRouter(),
        ],
      ),
      initialRoute: AuthRoutes.onBoarding,
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
