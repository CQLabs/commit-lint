import 'package:commit_lint/src/models/raw_config.dart';

class Config {
  final Map<String, Object> lintConfig;

  const Config({
    required this.lintConfig,
  });

  factory Config.fromRawConfig(RawConfig rawConfig) {
    final lintConfig = rawConfig.readMapOfMap(['lint']);

    return Config(lintConfig: lintConfig);
  }
}
