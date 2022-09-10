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

  Future<void> search() async {
    final response = await useCase.searchMovie(keywords: state.keywords);
    // response.when();
    final result = response.result;
    if (result is MoviesResponse) {
      emit(
        state.copy(
          movies: result,
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
