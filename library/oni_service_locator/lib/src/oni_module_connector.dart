import 'oni_service_locator.dart';

abstract class ModuleConnector {
  final OniServiceLocator serviceLocator;

  ModuleConnector(this.serviceLocator) {
    connect();
  }

  void connect();
}
