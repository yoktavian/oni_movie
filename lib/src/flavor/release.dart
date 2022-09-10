import 'package:entity_config/entity_config.dart';

/// in this case release must be running in production env
class ReleaseFlavor extends FlavorConfig {
  ReleaseFlavor()
      : super(
          apiKey: 'your-release-key',
          mode: Mode.release,
          env: Env.production,
        );
}
