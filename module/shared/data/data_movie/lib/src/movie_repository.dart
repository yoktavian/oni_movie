import 'package:async/async.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';

class MovieRepository extends GetMovies {
  final OniGet api;

  MovieRepository(this.api);

  @override
  Future<Result> get() async {
    return api.get(path: '/3/movie/now_playing');
  }
}
