import 'package:commit_lint/src/models/raw_config.dart';

class Config {
  final Map<String, Object> lintConfig;
  final bool ignoreMergeCommits;

  const Config({
    required this.lintConfig,
    required this.ignoreMergeCommits,
  });

  factory Config.fromRawConfig(RawConfig rawConfig) {
    final lintConfig = rawConfig.readMapOfMap(['lint']);
    final ignoreMergeCommits =
        rawConfig.config['ignore-merge-commits'] as bool? ?? true;

    return Config(
      lintConfig: lintConfig,
      ignoreMergeCommits: ignoreMergeCommits,
    );
  }
}
