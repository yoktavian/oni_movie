import 'package:flutter/material.dart';
import 'package:onion/onion.dart';

class OniTextStyle {
  static TextStyle get caption {
    return const TextStyle(
      fontSize: 12,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get body {
    return const TextStyle(
      fontSize: 14,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get bodyBold {
    return const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get h1 {
    return const TextStyle(
      fontSize: 16,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get h1Bold {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get h2 {
    return const TextStyle(
      fontSize: 18,
      color: OniColor.bleachedCedar,
    );
  }

  static TextStyle get h2Bold {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
      color: OniColor.bleachedCedar,
    );
  }
}
