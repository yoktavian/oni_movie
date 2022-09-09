import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

import '/src/page/login_page.dart';
import '/src/page/on_boarding_page.dart';
import 'package:oni_router/oni_router.dart';

class AuthRouter extends OniRouter {
  final OniServiceLocator serviceLocator;

  AuthRouter(this.serviceLocator);

  @override
  late ModuleConnector moduleConnector = AuthModuleConnector(serviceLocator);

  @override
  Map<String, WidgetBuilder> get routes {
    return {
      AuthRoutes.onBoarding: (_) => const OnBoardingPage(),
      AuthRoutes.login: (_) => const LoginPage(),
    };
  }
}

class AuthModuleConnector extends ModuleConnector {
  AuthModuleConnector(super.serviceLocator);

  @override
  void connect() {}
}
