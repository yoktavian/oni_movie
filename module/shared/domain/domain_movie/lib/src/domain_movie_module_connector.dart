import 'package:data_movie/data_movie.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:domain_movie/src/get_upcoming_movies_usecase.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DomainMovieModuleConnector extends ModuleConnector {
  DomainMovieModuleConnector(super.serviceLocator);

  @override
  void connect() {
    DataMovieModuleConnector(serviceLocator).connect();
    serviceLocator.registerFactory<GetNowPlayingMoviesUseCase>(
      () => GetNowPlayingMoviesUseCase(serviceLocator.getIt<GetNowPlayingMovies>()),
    );
    serviceLocator.registerFactory<GetUpComingMoviesUseCase>(
      () => GetUpComingMoviesUseCase(serviceLocator.getIt<GetUpcomingMovies>()),
    );
  }
}
