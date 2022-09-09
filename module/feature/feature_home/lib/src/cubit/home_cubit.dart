import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeLoadingState { loading, success, error }

class HomeState {
  final HomeLoadingState homeLoadingState;
  final MoviesResponse? nowPlayingMoviesData;
  final MoviesResponse? upcomingMoviesData;

  HomeState({
    this.homeLoadingState = HomeLoadingState.loading,
    this.nowPlayingMoviesData,
    this.upcomingMoviesData,
  });

  HomeState copy({
    HomeLoadingState? homeLoadingState,
    MoviesResponse? nowPlayingMoviesData,
    MoviesResponse? upcomingMoviesData,
  }) {
    return HomeState(
      homeLoadingState: homeLoadingState ?? this.homeLoadingState,
      nowPlayingMoviesData: nowPlayingMoviesData ?? this.nowPlayingMoviesData,
      upcomingMoviesData: upcomingMoviesData ?? this.upcomingMoviesData,
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

  void loadMovies() async {
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
    final result = await getNowPlayingMoviesUseCase.getMovies();
    if (result is ValueResult) {
      emit(
        state.copy(
          nowPlayingMoviesData: result.asValue.value as MoviesResponse,
        ),
      );
      return true;
    }
    return false;
  }

  Future<bool> fetchUpComingMovies() async {
    final result = await getUpComingMoviesUseCase.getMovies();
    if (result is ValueResult) {
      emit(
        state.copy(
          upcomingMoviesData: result.asValue.value as MoviesResponse,
        ),
      );
      return true;
    }
    return false;
  }
}
