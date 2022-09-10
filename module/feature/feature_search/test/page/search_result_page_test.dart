import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_search/src/page/search_result_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';

import '../test_helper/fake_search_movie_usecase.dart';
import '../test_helper/pump_widget.dart';

void main() {
  late final SearchMovieUseCase searchMovieUseCase;

  setUpAll(() {
    searchMovieUseCase = FakeSearchMovieUseCase();
    when(
      () => searchMovieUseCase.searchMovie(keywords: any(named: 'keywords')),
    ).thenAnswer(
      (invocation) => Future.value(
        OniResult(MoviesResponse()),
      ),
    );
  });

  group(
    'Home page test case',
    () {
      testWidgets(
        'Given home page '
        'When render the page '
        'Then must be contain home view.',
        (tester) async {
          final app = SearchResultPage(
            searchMovieUseCase: () => searchMovieUseCase,
          );
          await pumpWidgetWithArguments(
            tester,
            args: {SearchBundles.searchKeywords: '1'},
            child: app,
            route: SearchRoutes.searchResult,
          );
          expect(find.byType(SearchResultView), findsOneWidget);
        },
      );
    },
  );
}
