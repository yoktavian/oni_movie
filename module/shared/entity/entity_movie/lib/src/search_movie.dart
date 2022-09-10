import 'package:entity_api/entity_api.dart';

abstract class SearchMovie {
  static String path = '/3/search/movie';
  static String query = 'query';

  Future<OniResult> searchMovie(String keywords);
}
