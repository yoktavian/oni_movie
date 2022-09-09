import 'package:oni_api/oni_api.dart';

class ApiClient extends OniApi {
  ApiClient()
      : super(
    baseUrl: 'https://api.themoviedb.org',
    interceptors: [
      MovieClientInterceptor(),
    ],
  );
}

class MovieClientInterceptor extends OniApiInterceptor {
  @override
  Map<String, dynamic> get queryParams {
    return {
      'api_key': '6d9463ea75dd62fcccc52f2b0edc5214'
    };
  }
}
