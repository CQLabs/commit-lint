import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';

abstract class MinLengthRule extends LintRule {
  final String _type;
  final _MinLengthConfig _config;

  MinLengthRule(Map<String, Object> config, this._type)
      : _config = _MinLengthConfig.fromConfigMap(config, '$_type-min-length'),
        super(id: '$_type-min-length');

  @override
  LintIssue check(String? content) => LintIssue(
        _config.isEnabled
            ? checkMinLength(_config.minLength, content, _type)
            : null,
        _config.severity,
      );
}

class _MinLengthConfig {
  final num minLength;

  final Severity severity;
  final bool isEnabled;

  const _MinLengthConfig._({
    required this.minLength,
    required this.severity,
    required this.isEnabled,
  });

  factory _MinLengthConfig.fromConfigMap(
      Map<String, Object> rawLintConfig, String ruleId) {
    final config = rawLintConfig[ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return _MinLengthConfig._(
      isEnabled: rawLintConfig.containsKey(ruleId),
      minLength: configMap['length'] as int? ?? 0,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
