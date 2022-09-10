import 'src/starter/debug_starter.dart';
import '/src/flavor/debug.dart';
import 'package:oni_service_locator/oni_service_locator.dart';

/// main should run debug flavor
void main() {
  final serviceLocator = OniServiceLocatorImpl();
  DebugStarter.start(config: DebugFlavor(), serviceLocator: serviceLocator);
}
