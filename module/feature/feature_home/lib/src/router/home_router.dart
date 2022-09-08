import 'package:domain_movie/domain_movie.dart';
import 'package:feature_home/src/page/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class HomeRouter extends OniRouter {
  final OniServiceLocator serviceLocator;

  HomeRouter(this.serviceLocator);

  @override
  late ModuleConnector moduleConnector = HomeModuleConnector(serviceLocator);

  @override
  Map<String, WidgetBuilder> get routes {
    return {
      HomeRoutes.home: (_) {
        return HomePage(
          () => serviceLocator.getIt<GetMovieUseCase>(),
        );
      }
    };
  }
}

class HomeModuleConnector extends ModuleConnector {
  HomeModuleConnector(super.serviceLocator);

  @override
  void connect() {
    DomainMovieModuleConnector(serviceLocator).connect();
  }
}
