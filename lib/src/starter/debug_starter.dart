import 'package:api_client/api_client.dart';
import 'package:entity_config/entity_config.dart';
import 'package:flutter/widgets.dart';
import 'package:oni_api/oni_api.dart';
import 'package:oni_movie/src/app.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

class DebugStarter {
  static void start({
    required FlavorConfig config,
    required OniServiceLocator serviceLocator,
  }) async {
    await _initializeProject(config, serviceLocator);
    runApp(OniMovieApp(config, serviceLocator));
  }
}

Future<void> _initializeProject(
  FlavorConfig config,
  OniServiceLocator serviceLocator,
) async {
  serviceLocator.registerSingleton<OniApi>(
    () => ApiClient(config),
  );
}
