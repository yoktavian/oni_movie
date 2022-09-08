import 'package:flutter/widgets.dart';

import '/src/page/login_page.dart';
import '/src/page/on_boarding_page.dart';
import 'package:oni_router/oni_router.dart';

class AuthRouter extends OniRouter {
  @override
  Map<String, WidgetBuilder> get routes {
    return {
      AuthBundle.onBoardingRoute: (_) => const OnBoardingPage(),
      AuthBundle.loginRoute: (_) => const LoginPage(),
    };
  }
}
