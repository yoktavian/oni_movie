import 'package:feature_home/src/page/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:oni_router/oni_router.dart';

class HomeRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes {
    return {
      HomeBundle.homeRoute: (_) {
        return const HomePage();
      }
    };
  }
}
