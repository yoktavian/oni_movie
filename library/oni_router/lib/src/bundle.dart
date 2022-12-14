import 'package:flutter/widgets.dart';

extension BundleExtension on BuildContext {
  /// use opt when it is optional and the value is nullable
  T? opt<T>(String bundle) {
    final arguments = ModalRoute.of(this)?.settings.arguments;
    if (arguments == null) return null;
    return (arguments as Map)[bundle] as T;
  }

  /// use get when the value is required, so it will throw an exception
  /// when the required data was null.
  T get<T>(String bundle) {
    return (ModalRoute.of(this)?.settings.arguments as Map)[bundle] as T;
  }
}
