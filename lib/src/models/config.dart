import 'package:commit_lint/src/models/raw_config.dart';
import 'package:commit_lint/src/rules/type/type_config.dart';
import 'package:commit_lint/src/rules/type/type_rule.dart';

class Config {
  final TypeConfig typeConfig;

  const Config({
    required this.typeConfig,
  });

  factory Config.fromRawConfig(RawConfig rawConfig) {
    const _lintKey = 'lint';

    return Config(
      typeConfig: TypeConfig.fromConfigMap(
        rawConfig.readMap([_lintKey, TypeRule.ruleId]),
      ),
    );
  }
}
