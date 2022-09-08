import 'package:flutter/widgets.dart';

class AuthBundle {
  static const onBoardingRoute = '/auth';
  static const loginRoute = '/auth/login';
}

class HomeBundle {
  static const homeRoute = '/home';
}

extension BundleExtension on BuildContext {
  T bundle<T>(String bundle) {
    return (ModalRoute.of(this)?.settings.arguments as Map)[bundle] as T;
  }
}
