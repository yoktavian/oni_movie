import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_home/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helper/fake_get_now_playing_movie_usecase.dart';
import '../test_helper/fake_get_upcoming_movie_usecase.dart';


void main() {
  late final GetNowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  late final GetUpComingMoviesUseCase upComingMoviesUseCase;

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
    'Home page test case',
    () {
      testWidgets(
        'Given home page '
        'When render the page '
        'Then must be contain home view.',
        (tester) async {
          final app = MaterialApp(
            home: HomePage(
              () => nowPlayingMoviesUseCase,
              () => upComingMoviesUseCase,
            ),
          );
          await tester.pumpWidget(app);
          expect(find.byType(HomeView), findsOneWidget);
        },
      );
    },
  );
}
