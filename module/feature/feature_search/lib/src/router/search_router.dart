import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_search/src/page/search_result_page.dart';
import 'package:flutter/widgets.dart';
import 'package:navigation/navigation.dart';
import 'package:oni_router/oni_router.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class SearchRouter extends OniRouter {
  final OniServiceLocator serviceLocator;

  SearchRouter(this.serviceLocator);

  @override
  late ModuleConnector moduleConnector = SearchModuleConnector(serviceLocator);

  @override
  Map<String, WidgetBuilder> get routes {
    return {
      SearchRoutes.searchResult: (context) {
        return SearchResultPage(
          searchMovieUseCase: () => serviceLocator.getIt<SearchMovieUseCase>(),
        );
      }
    };
  }
}

class SearchModuleConnector extends ModuleConnector {
  SearchModuleConnector(super.serviceLocator);
}
