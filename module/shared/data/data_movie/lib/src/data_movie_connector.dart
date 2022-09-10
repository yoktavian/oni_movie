import 'package:data_movie/src/movie_repository.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DataMovieConnector {
  static void connect(OniServiceLocator serviceLocator) {
    serviceLocator.registerFactory<GetNowPlayingMovies>(
      () => MovieRepository(serviceLocator.getIt<OniApi>()),
    );
    serviceLocator.registerFactory<GetUpcomingMovies>(
      () => MovieRepository(serviceLocator.getIt<OniApi>()),
    );
    serviceLocator.registerFactory<SearchMovie>(
      () => MovieRepository(serviceLocator.getIt<OniApi>()),
    );
  }
}
