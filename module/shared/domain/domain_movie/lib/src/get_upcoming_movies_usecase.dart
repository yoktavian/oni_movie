import 'package:async/async.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:flutter/foundation.dart';

class GetUpComingMoviesUseCase {
  final GetUpcomingMovies repository;
  GetUpComingMoviesUseCase(this.repository);

  Future<Result> getMovies() async {
    final response = await repository.getUpComingMovies();
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
