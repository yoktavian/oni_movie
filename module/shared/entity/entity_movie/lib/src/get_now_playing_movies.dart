import 'package:async/async.dart';

abstract class GetNowPlayingMovies {
  Future<Result> getNowPlayingMovies();
}
