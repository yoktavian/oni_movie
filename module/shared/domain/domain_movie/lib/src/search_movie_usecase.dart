import 'package:async/async.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter/foundation.dart';

class SearchMovieUseCase {
  final SearchMovie repository;
  SearchMovieUseCase(this.repository);

  Future<OniResult> searchMovie(String keywords) async {
    final response = await repository.searchMovie(keywords);
    if (response.result is OniException) {
      return response;
    }
    final trackResponse = await compute(_parseMovie, response.result);
    return OniResult(trackResponse);
  }
}

MoviesResponse _parseMovie(json) {
  return MoviesResponse.fromJson(json);
}
