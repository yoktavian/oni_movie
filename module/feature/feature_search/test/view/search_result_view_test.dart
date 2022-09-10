import 'package:domain_movie/domain_movie.dart';
import 'package:feature_search/src/cubit/search_cubit.dart';
import 'package:feature_search/src/page/search_result_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../test_helper/fake_search_movie_usecase.dart';

void main() {
  late final SearchMovieUseCase searchMovieUseCase;
  late SearchCubit cubit;

  setUpAll(() {
    searchMovieUseCase = FakeSearchMovieUseCase();
  });

  group(
    'Search view test case',
    () {
      testWidgets(
        'Given loading condition '
        'When user open search page '
        'Then loading widget must be shown.',
        (tester) async {
          cubit = SearchCubit(
            searchMovieUseCase,
            SearchState(loadingState: SearchLoadingState.loading),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const SearchResultView(),
            ),
          );
          await tester.pumpWidget(app);
          expect(find.byKey(SearchResultView.loadingKey), findsOneWidget);
        },
      );

      testWidgets(
        'Given api req success condition '
        'When user open search page '
        'Then all of widgets must be shown properly and loading widget must '
        'be disappear.',
        (tester) async {
          cubit = SearchCubit(
            searchMovieUseCase,
            SearchState(loadingState: SearchLoadingState.success),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const SearchResultView(),
            ),
          );
          await tester.pumpWidget(app);
          expect(find.byKey(SearchResultView.loadingKey), findsNothing);
          expect(find.byKey(SearchResultView.snackBarErrorKey), findsNothing);
          expect(find.byKey(SearchResultView.backKey), findsOneWidget);
          expect(find.byKey(SearchResultView.headerSectionKey), findsOneWidget);
          expect(
            find.byKey(SearchResultView.searchResultTitleKey),
            findsOneWidget,
          );
          expect(
            find.byKey(SearchResultView.searchResultSection),
            findsOneWidget,
          );
        },
      );

      testWidgets(
        'Given api req failed condition '
        'When user open search page '
        'Then snackbar error must be shown.',
        (tester) async {
          cubit = SearchCubit(
            searchMovieUseCase,
            SearchState(loadingState: SearchLoadingState.error),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const SearchResultView(),
            ),
          );
          await tester.pumpWidget(app);
          cubit.emit(cubit.state);
          await tester.pump();
          expect(find.byKey(SearchResultView.snackBarErrorKey), findsOneWidget);
        },
      );
    },
  );
}
