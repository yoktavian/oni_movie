import 'package:async/async.dart';
import 'package:entity_api/entity_api.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';

class MovieRepository
    implements GetNowPlayingMovies, GetUpcomingMovies, SearchMovie {
  final OniGet api;

  MovieRepository(this.api);

  @override
  Future<OniResult> getNowPlayingMovies() async {
    return api.get(path: GetNowPlayingMovies.path);
  }

  @override
  Future<OniResult> getUpComingMovies() async {
    return api.get(path: GetUpcomingMovies.path);
  }

  @override
  Future<OniResult> searchMovie(String keywords) {
    return api.get(
      path: SearchMovie.path,
      queryParameters: {SearchMovie.query: keywords},
    );
  }
}
