import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeState {
  final MoviesResponse? moviesResponse;

  HomeState({this.moviesResponse});

  HomeState copy({MoviesResponse? moviesResponse}) {
    return HomeState(
      moviesResponse: moviesResponse ?? this.moviesResponse,
    );
  }
}

class HomeCubit extends Cubit<HomeState> {
  final GetMovieUseCase useCase;

  HomeCubit(this.useCase, super.initialState);

  void fetchMovies() async {
    final result = await useCase.getMovies();
    if (result is ValueResult) {
      emit(state.copy(moviesResponse: result.asValue.value as MoviesResponse));
    }
  }
}
