import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_home/src/cubit/home_cubit.dart';
import 'package:feature_home/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navigation/navigation.dart';

import '../test_helper/fake_get_now_playing_movie_usecase.dart';
import '../test_helper/fake_get_upcoming_movie_usecase.dart';

void main() {
  late final GetNowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  late final GetUpComingMoviesUseCase upComingMoviesUseCase;
  late HomeCubit cubit;

  setUpAll(() {
    nowPlayingMoviesUseCase = FakeGetNowPlayingMovieUseCase();
    upComingMoviesUseCase = FakeGetUpcomingMovieUseCase();
    when(() => nowPlayingMoviesUseCase.getMovies()).thenAnswer(
      (invocation) => Future.value(
        OniResult(MoviesResponse()),
      ),
    );
    when(() => upComingMoviesUseCase.getMovies()).thenAnswer(
      (invocation) => Future.value(
        OniResult(MoviesResponse()),
      ),
    );
  });

  group(
    'Home view test case',
    () {
      testWidgets(
        'Given loading condition state '
        'When user open home '
        'Then loading widget must be shown.',
        (tester) async {
          cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(homeLoadingState: HomeLoadingState.loading),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const HomeView(),
            ),
          );
          await tester.pumpWidget(app);
          expect(find.byKey(HomeView.loadingKey), findsOneWidget);
        },
      );

      testWidgets(
        'Given error condition state and have some error message '
        'When user open home '
        'Then snackbar must be shown with certain error message.',
        (tester) async {
          const errorMessage = 'Error network';
          cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(
              homeLoadingState: HomeLoadingState.error,
              errorMessage: errorMessage,
            ),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const HomeView(),
            ),
          );
          await tester.pumpWidget(app);
          // to trigger listener on the first render.
          cubit.emit(cubit.state);
          // add 1 frame to show the snackbar
          await tester.pump();
          expect(find.byKey(HomeView.snackBarErrorKey), findsOneWidget);
        },
      );

      testWidgets(
        'Given all of api req success condition '
        'When user open home '
        'Then search bar, now playing movie section, and upcoming movie section'
        'must be shown.',
        (tester) async {
          cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(
              homeLoadingState: HomeLoadingState.success,
            ),
          );
          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const HomeView(),
            ),
          );
          await tester.pumpWidget(app);
          expect(find.byKey(HomeView.searchBarKey), findsOneWidget);
          expect(find.byKey(HomeView.nowPlayingSectionKey), findsOneWidget);
          expect(find.byKey(HomeView.upcomingTitleKey), findsOneWidget);
          expect(find.byKey(HomeView.upcomingSectionKey), findsOneWidget);
        },
      );

      testWidgets(
        'Given all of api req success condition '
        'When user open home '
        'Then search bar must be shown and '
        'When user perform search must be redirect to search result page',
        (tester) async {
          cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(
              homeLoadingState: HomeLoadingState.success,
            ),
          );
          const dummySearchPageKey = Key('dummy-search-page');

          final app = MaterialApp(
            home: BlocProvider.value(
              value: cubit,
              child: const HomeView(),
            ),
            routes: {
              SearchRoutes.searchResult: (_) {
                return const SizedBox(
                  key: dummySearchPageKey,
                );
              }
            },
          );
          await tester.pumpWidget(app);
          await tester.enterText(
            find.byKey(HomeView.searchBarKey),
            'Spiderman',
          );
          await tester.testTextInput.receiveAction(TextInputAction.done);
          // close the keyboard
          await tester.pump();
          // open search page
          await tester.pump();
          expect(find.byKey(dummySearchPageKey), findsOneWidget);
        },
      );
    },
  );
}
