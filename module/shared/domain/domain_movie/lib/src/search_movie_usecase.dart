import 'package:async/async.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter/foundation.dart';

class SearchMovieUseCase {
  final SearchMovie repository;
  SearchMovieUseCase(this.repository);

  Future<Result> searchMovie(String keywords) async {
    final response = await repository.searchMovie(keywords);
    if (response is ValueResult) {
      final trackResponse = await compute(_parseMovie, response.asValue.value);
      return Result.value(trackResponse);
    }
    return Result.error(response);
  }
}

MoviesResponse _parseMovie(json) {
  return MoviesResponse.fromJson(json);
}
