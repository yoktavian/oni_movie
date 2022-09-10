import 'package:async/async.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';

class MovieRepository implements GetNowPlayingMovies, GetUpcomingMovies {
  final OniGet api;

  MovieRepository(this.api);

  @override
  Future<Result> getNowPlayingMovies() async {
    return api.get(path: '/3/movie/now_playing');
  }

  @override
  Future<Result> getUpComingMovies() async {
    return api.get(path: '/3/movie/upcoming');
  }
}
