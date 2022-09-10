import 'package:entity_config/entity_config.dart';

/// in this case debug must be running in staging env
class DebugFlavor extends FlavorConfig {
  DebugFlavor()
      : super(
          apiKey: 'your-debug-key',
          mode: Mode.debug,
          env: Env.staging,
        );
}
