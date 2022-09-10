enum Mode {
  debug,
  release,
}

enum Env {
  production,
  staging,
}

abstract class Config {
  final String apiKey;
  final Mode mode;
  final Env env;

  Config({required this.apiKey, required this.mode, required this.env});
}
