import '/src/flavor/release.dart';
import 'src/starter/release_starter.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

/// main should run release flavor
void main() {
  final serviceLocator = OniServiceLocatorImpl();
  ReleaseStarter.start(config: ReleaseFlavor(), serviceLocator: serviceLocator);
}
