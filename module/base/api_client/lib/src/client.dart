import 'package:entity_config/entity_config.dart';
import 'package:oni_api/oni_api.dart';

class ApiClient extends OniApi {
  ApiClient(FlavorConfig config)
      : super(
          baseUrl: 'https://api.themoviedb.org',
          interceptors: [
            MovieClientInterceptor(config),
          ],
        );
}

class MovieClientInterceptor extends OniApiInterceptor {
  final FlavorConfig config;
  MovieClientInterceptor(this.config);

  @override
  Map<String, dynamic> get queryParams {
    return {'api_key': config.apiKey};
  }
}
