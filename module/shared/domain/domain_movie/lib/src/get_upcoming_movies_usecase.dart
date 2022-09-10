import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter/foundation.dart';

class GetUpComingMoviesUseCase {
  final GetUpcomingMovies repository;
  GetUpComingMoviesUseCase(this.repository);

  Future<OniResult> getMovies() async {
    final response = await repository.getUpComingMovies();
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
