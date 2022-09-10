import 'package:flutter/widgets.dart';
import 'package:oni_service_locator/src/oni_service_factory.dart';
import 'package:oni_service_locator/src/oni_service_locator.dart';

class OniServiceLocatorImpl extends OniServiceLocator {
  @override
  void registerFactory<T extends Object>(ValueGetter<T> factory) {
    if (serviceFactoryContainer[T] != null) return;
    serviceFactoryContainer[T] = OniServiceFactory(factory, ClassType.factory);
  }

  @override
  void registerSingleton<T extends Object>(ValueGetter<T> instance) {
    if (serviceFactoryContainer[T] != null) return;
    serviceFactoryContainer[T] = OniServiceFactory(
      instance,
      ClassType.singleton,
    );
  }

  @override
  T getIt<T>() {
    if (container[T] != null) return container[T] as T;

    final factoryContainer = serviceFactoryContainer[T];
    if (factoryContainer is OniServiceFactory) {
      final object = factoryContainer.object() as T;
      if (object != null) container[T] = object;

      if (factoryContainer.type == ClassType.factory) {
        container.remove(T);
      }
      return object;
    }

    throw ('$T is not registered yet in the service locator');
  }

  @override
  void clear() {
    container.clear();
    serviceFactoryContainer.clear();
  }
}
