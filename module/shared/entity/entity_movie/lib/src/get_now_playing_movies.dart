import 'package:async/async.dart';

abstract class GetNowPlayingMovies {
  static String path = '/3/movie/now_playing';

  Future<Result> getNowPlayingMovies();
}
