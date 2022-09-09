import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';

class MovieRepository extends GetMovie {
  final OniGet api;

  MovieRepository(this.api);

  @override
  Future<String> get() {
    api.get(path: '/3/movie/550');
    return Future.value('halo from repo');
  }
}
