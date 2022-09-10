import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeLoadingState { loading, success, error }

class HomeState {
  final HomeLoadingState homeLoadingState;
  final MoviesResponse? nowPlayingMoviesData;
  final MoviesResponse? upcomingMoviesData;
  final String? errorMessage;

  HomeState({
    this.homeLoadingState = HomeLoadingState.loading,
    this.nowPlayingMoviesData,
    this.upcomingMoviesData,
    this.errorMessage,
  });

  HomeState copy({
    HomeLoadingState? homeLoadingState,
    MoviesResponse? nowPlayingMoviesData,
    MoviesResponse? upcomingMoviesData,
    String? errorMessage,
  }) {
    return HomeState(
      homeLoadingState: homeLoadingState ?? this.homeLoadingState,
      nowPlayingMoviesData: nowPlayingMoviesData ?? this.nowPlayingMoviesData,
      upcomingMoviesData: upcomingMoviesData ?? this.upcomingMoviesData,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  final GetUpComingMoviesUseCase getUpComingMoviesUseCase;

  HomeCubit(
    this.getNowPlayingMoviesUseCase,
    this.getUpComingMoviesUseCase,
    super.initialState,
  );

  Future<void> loadMovies() async {
    if (state.homeLoadingState != HomeLoadingState.loading) {
      emit(state.copy(homeLoadingState: HomeLoadingState.loading));
    }

    final nowPlayingMoviesFetchSuccess = await fetchNowPlayingMovies();
    final upcomingMoviesFetchSuccess = await fetchUpComingMovies();
    if (nowPlayingMoviesFetchSuccess && upcomingMoviesFetchSuccess) {
      emit(state.copy(homeLoadingState: HomeLoadingState.success));
    } else {
      emit(state.copy(homeLoadingState: HomeLoadingState.error));
    }
  }

  Future<bool> fetchNowPlayingMovies() async {
    final response = await getNowPlayingMoviesUseCase.getMovies();
    bool isSuccess = true;
    response.when<MoviesResponse>(
      success: (value) {
        emit(
          state.copy(
            nowPlayingMoviesData: value,
          ),
        );
      },
      error: (error) {
        emit(
          state.copy(errorMessage: error.message),
        );
        isSuccess = false;
      },
    );
    return isSuccess;
  }

  Future<bool> fetchUpComingMovies() async {
    final response = await getUpComingMoviesUseCase.getMovies();
    bool isSuccess = true;
    response.when<MoviesResponse>(
      success: (value) {
        emit(
          state.copy(
            upcomingMoviesData: value,
          ),
        );
      },
      error: (error) {
        emit(
          state.copy(errorMessage: error.message),
        );
        isSuccess = false;
      },
    );
    return isSuccess;
  }
}
