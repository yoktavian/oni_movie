import 'package:entity_movie/entity_movie.dart';

class GetMovieUseCase {
  final GetMovie repository;
  GetMovieUseCase(this.repository);

  Future<String> getMovies() async {
    return repository.get();
  }
}
