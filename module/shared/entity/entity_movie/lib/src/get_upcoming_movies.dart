import 'package:entity_api/entity_api.dart';

abstract class GetUpcomingMovies {
  static String path = '/3/movie/upcoming';

  Future<OniResult> getUpComingMovies();
}
