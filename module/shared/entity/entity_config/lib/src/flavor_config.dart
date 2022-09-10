enum Mode {
  debug,
  release,
}

enum Env {
  production,
  staging,
}

abstract class FlavorConfig {
  final String apiKey;
  final Mode mode;
  final Env env;

  FlavorConfig({required this.apiKey, required this.mode, required this.env});
}
