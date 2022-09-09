import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum HomeLoadingState { loading, success, error }

class HomeState {
  final HomeLoadingState homeLoadingState;
  final MoviesResponse? moviesResponse;

  HomeState({
    this.homeLoadingState = HomeLoadingState.loading,
    this.moviesResponse,
  });

  HomeState copy({
    HomeLoadingState? homeLoadingState,
    MoviesResponse? moviesResponse,
  }) {
    return HomeState(
      homeLoadingState: homeLoadingState ?? this.homeLoadingState,
      moviesResponse: moviesResponse ?? this.moviesResponse,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final GetMovieUseCase useCase;

  HomeCubit(this.useCase, super.initialState);

  void fetchMovies() async {
    if (state.homeLoadingState != HomeLoadingState.loading) {
      emit(state.copy(homeLoadingState: HomeLoadingState.loading));
    }

    final result = await useCase.getMovies();
    if (result is ValueResult) {
      emit(
        state.copy(
          moviesResponse: result.asValue.value as MoviesResponse,
          homeLoadingState: HomeLoadingState.success,
        ),
      );
    } else {
      state.copy(homeLoadingState: HomeLoadingState.error);
    }
  }
}
