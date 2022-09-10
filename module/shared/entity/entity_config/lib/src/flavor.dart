import 'package:entity_config/src/config.dart';

class Debug extends Config {
  Debug(): super(apiKey: '', mode: Mode.debug, env: Env.staging);
}

class Release extends Config {
  Release(): super(apiKey: '', mode: Mode.debug, env: Env.staging);
}
