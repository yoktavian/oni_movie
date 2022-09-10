import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:feature_home/src/cubit/home_cubit.dart';
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
  });

  group(
    'Home cubit test case',
    () {
      test(
        'Given all api request success '
        'When loadMovies has been finish '
        'Then loadingState must be success & error message should be null.',
        () async {
          // given
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
          final cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(),
          );

          // when
          await cubit.loadMovies();

          // then
          final cubitState = cubit.state;
          expect(cubitState.homeLoadingState, HomeLoadingState.success);
          expect(cubitState.errorMessage, null);
        },
      );

      test(
        'Given one of api request failed '
        'When loadMovies has been finish '
        'Then loadingState must be error & should have correct error message.',
        () async {
          // given
          const errorMessage = 'Error network';
          when(() => nowPlayingMoviesUseCase.getMovies()).thenAnswer(
            (invocation) => Future.value(
              OniResult(MoviesResponse()),
            ),
          );
          when(() => upComingMoviesUseCase.getMovies()).thenAnswer(
            (invocation) => Future.value(
              OniResult(OniException(errorMessage)),
            ),
          );
          final cubit = HomeCubit(
            nowPlayingMoviesUseCase,
            upComingMoviesUseCase,
            HomeState(),
          );

          // when
          await cubit.loadMovies();

          // then
          final cubitState = cubit.state;
          expect(cubitState.homeLoadingState, HomeLoadingState.error);
          expect(cubitState.errorMessage, errorMessage);
        },
      );
    },
  );
}
