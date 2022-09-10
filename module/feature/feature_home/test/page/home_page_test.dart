import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_home/src/page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _FakeGetNowPlayingMovieUseCase extends Mock
    implements GetNowPlayingMoviesUseCase {}

class _FakeGetUpComingMoviesUseCase extends Mock
    implements GetUpComingMoviesUseCase {}

void main() {
  late final GetNowPlayingMoviesUseCase nowPlayingMoviesUseCase;
  late final GetUpComingMoviesUseCase upComingMoviesUseCase;

  setUpAll(() {
    nowPlayingMoviesUseCase = _FakeGetNowPlayingMovieUseCase();
    upComingMoviesUseCase = _FakeGetUpComingMoviesUseCase();
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
