import 'package:data_movie/data_movie.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DomainMovieConnector {
  static void connect(OniServiceLocator serviceLocator) {
    DataMovieConnector.connect(serviceLocator);
    serviceLocator.registerFactory<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMoviesUseCase(serviceLocator.getIt<GetNowPlayingMovies>()),
    );
    serviceLocator.registerFactory<GetUpComingMoviesUseCase>(
      () => GetUpComingMoviesUseCase(serviceLocator.getIt<GetUpcomingMovies>()),
    );
  }
}
