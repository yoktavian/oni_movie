import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';

import '/src/page/login_page.dart';
import '/src/page/on_boarding_page.dart';
import 'package:oni_router/oni_router.dart';

class AuthRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes {
    return {
      AuthRoutes.onBoarding: (_) => const OnBoardingPage(),
      AuthRoutes.login: (_) => const LoginPage(),
    };
  }
}
