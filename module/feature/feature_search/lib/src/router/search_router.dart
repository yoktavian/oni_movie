import 'package:feature_search/src/page/search_result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class SearchRouter extends OniRouter {
  final OniServiceLocator serviceLocator;

  SearchRouter(this.serviceLocator);

  @override
  late ModuleConnector moduleConnector = HomeModuleConnector(serviceLocator);

  @override
  Map<String, WidgetBuilder> get routes  {
    return {
      SearchRoutes.searchResult: (context) {
        return const SearchResultPage();
      }
    };
  }
}

class HomeModuleConnector extends ModuleConnector {
  HomeModuleConnector(super.serviceLocator);

  @override
  void connect() {

  }
}
