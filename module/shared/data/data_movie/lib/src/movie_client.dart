import 'package:oni_api/oni_api.dart';

class MovieClient extends OniApi {
  MovieClient(): super(baseUrl: 'https://api.themoviedb.org');
}

class MovieClientInterceptor extends OniApiInterceptor {
  @override
  Map<String, dynamic> get queryParams {
    return {
      'api_key': '6d9463ea75dd62fcccc52f2b0edc5214'
    };
  }
}
