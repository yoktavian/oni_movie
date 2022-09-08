import 'package:entity_movie/entity_movie.dart';

class MovieRepository extends GetMovie {
  @override
  Future<String> get() {
    return Future.value('halo from repo');
  }
}
