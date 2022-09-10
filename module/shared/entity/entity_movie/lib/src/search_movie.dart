import 'package:async/async.dart';

abstract class SearchMovie {
  static String path = '/3/search/movie';
  static String query = 'query';

  Future<Result> searchMovie(String keywords);
}
