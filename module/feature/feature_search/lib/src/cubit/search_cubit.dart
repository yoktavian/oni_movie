import 'package:async/async.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum SearchLoadingState { loading, success, error }

class SearchState {
  final String keywords;
  final MoviesResponse? movies;
  final SearchLoadingState loadingState;

  SearchState({
    this.keywords = '',
    this.movies,
    this.loadingState = SearchLoadingState.loading,
  });

  SearchState copy({
    String? keywords,
    SearchLoadingState? loadingState,
    MoviesResponse? movies,
  }) {
    return SearchState(
      keywords: keywords ?? this.keywords,
      loadingState: loadingState ?? this.loadingState,
      movies: movies ?? this.movies,
    );
  }
}

class SearchCubit extends Cubit<SearchState> {
  final SearchMovieUseCase useCase;

  SearchCubit(this.useCase, super.initialState);

  void search() async {
    final result = await useCase.searchMovie(state.keywords);
    if (result is ValueResult) {
      emit(
        state.copy(
          movies: result.asValue.value,
          loadingState: SearchLoadingState.success,
        ),
      );
    } else {
      emit(
        state.copy(
          loadingState: SearchLoadingState.error,
        ),
      );
    }
  }
}
