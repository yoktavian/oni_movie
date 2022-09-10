import 'package:entity_api/entity_api.dart';

abstract class GetNowPlayingMovies {
  static String path = '/3/movie/now_playing';

  Future<OniResult> getNowPlayingMovies();
}
