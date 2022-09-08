import 'package:data_movie/src/movie_repository.dart';
import 'package:entity_movie/entity_movie.dart';
import 'package:oni_api/oni_api.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DataMovieModuleConnector extends ModuleConnector {
  DataMovieModuleConnector(super.serviceLocator);

  @override
  void connect() {
    serviceLocator.registerFactory<GetMovie>(
      () => MovieRepository(serviceLocator.getIt<OniApi>()),
    );
  }
}
