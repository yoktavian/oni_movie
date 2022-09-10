import 'package:async/async.dart';

abstract class GetUpcomingMovies {
  static String path = '/3/movie/upcoming';

  Future<Result> getUpComingMovies();
}
