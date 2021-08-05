import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';

abstract class MaxLengthRule extends LintRule {
  final String _type;
  final _MaxLengthConfig _config;

  MaxLengthRule(Map<String, Object> config, this._type)
      : _config = _MaxLengthConfig.fromConfigMap(config, '$_type-max-length'),
        super(id: '$_type-max-length');

  @override
  LintIssue check(String? content) => LintIssue(
        _config.isEnabled
            ? checkMaxLength(_config.maxLength, content, _type)
            : null,
        _config.severity,
      );
}

class _MaxLengthConfig {
  final num maxLength;

  final Severity severity;
  final bool isEnabled;

  const _MaxLengthConfig._({
    required this.maxLength,
    required this.severity,
    required this.isEnabled,
  });

  factory _MaxLengthConfig.fromConfigMap(
      Map<String, Object> rawLintConfig, String ruleId) {
    final config = rawLintConfig[ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return _MaxLengthConfig._(
      isEnabled: rawLintConfig.containsKey(ruleId),
      maxLength: configMap['length'] as int? ?? double.infinity,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
