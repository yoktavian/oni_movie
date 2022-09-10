import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_search/src/cubit/search_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helper/fake_search_movie_usecase.dart';

void main() {
  late final SearchMovieUseCase searchMovieUseCase;
  late SearchCubit cubit;

  setUpAll(() {
    searchMovieUseCase = FakeSearchMovieUseCase();
    const keywords = 'spiderman';
    cubit = SearchCubit(
      searchMovieUseCase,
      SearchState(keywords: keywords),
    );
  });

  group(
    'Search view test case',
    () {
      test(
        'Given api search return error '
        'When search has been finish '
        'Then searchLoadingState must be error.',
        () async {
          when(
            () => searchMovieUseCase.searchMovie(
              keywords: any(named: 'keywords'),
            ),
          ).thenAnswer((_) {
            return Future.value(OniResult(OniException('Error network')));
          });
          const keywords = 'spiderman';
          cubit = SearchCubit(
            searchMovieUseCase,
            SearchState(keywords: keywords),
          );
          await cubit.search();
          expect(cubit.state.keywords, keywords);
          expect(cubit.state.loadingState, SearchLoadingState.error);
        },
      );

      test(
        'Given api search return success '
        'When search has been finish '
        'Then searchLoadingState must be error.',
        () async {
          when(
            () => searchMovieUseCase.searchMovie(
              keywords: any(named: 'keywords'),
            ),
          ).thenAnswer((_) {
            return Future.value(OniResult(MoviesResponse()));
          });
          const keywords = 'spiderman';
          cubit = SearchCubit(
            searchMovieUseCase,
            SearchState(keywords: keywords),
          );
          await cubit.search();
          expect(cubit.state.keywords, keywords);
          expect(cubit.state.loadingState, SearchLoadingState.success);
        },
      );
    },
  );
}
