import 'package:flutter/widgets.dart';

enum ClassType { factory, singleton }

class OniServiceFactory {
  ValueGetter<Object> object;
  ClassType type;

  OniServiceFactory(this.object, this.type);
}
