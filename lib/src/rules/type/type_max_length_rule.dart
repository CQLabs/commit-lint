import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypeMaxLengthRule extends LintRule {
  static const String ruleId = 'type-max-length';

  final TypeMaxLengthConfig _config;

  TypeMaxLengthRule(Map<String, Object> config)
      : _config = TypeMaxLengthConfig.fromConfigMap(config),
        super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) => LintIssue(
        checkMaxLength(_config.maxLength, commit.type, 'type'),
        _config.severity,
      );
}

class TypeMaxLengthConfig {
  final num maxLength;

  final Severity severity;

  const TypeMaxLengthConfig._({
    required this.maxLength,
    required this.severity,
  });

  factory TypeMaxLengthConfig.fromConfigMap(Map<String, Object> rawLintConfig) {
    final config = rawLintConfig[TypeMaxLengthRule.ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return TypeMaxLengthConfig._(
      maxLength: configMap['length'] as int? ?? double.infinity,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
