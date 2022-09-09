import 'package:data_movie/data_movie.dart';
import 'package:domain_movie/domain_movie.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DomainMovieModuleConnector extends ModuleConnector {
  DomainMovieModuleConnector(super.serviceLocator);

  @override
  void connect() {
    DataMovieModuleConnector(serviceLocator).connect();
    serviceLocator.registerFactory<GetMovieUseCase>(
      () => GetMovieUseCase(serviceLocator.getIt<GetMovies>()),
    );
  }
}
