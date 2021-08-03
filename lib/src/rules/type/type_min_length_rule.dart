import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypeMinLengthRule extends LintRule {
  static const String ruleId = 'type-min-length';

  final TypeMinLengthConfig _config;

  TypeMinLengthRule(Map<String, Object> config)
      : _config = TypeMinLengthConfig.fromConfigMap(config),
        super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) => LintIssue(
        checkMinLength(_config.minLength, commit.type, 'type'),
        _config.severity,
      );
}

class TypeMinLengthConfig {
  final num minLength;

  final Severity severity;

  const TypeMinLengthConfig._({
    required this.minLength,
    required this.severity,
  });

  factory TypeMinLengthConfig.fromConfigMap(Map<String, Object> rawLintConfig) {
    final config = rawLintConfig[TypeMinLengthRule.ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return TypeMinLengthConfig._(
      minLength: configMap['length'] as int? ?? 0,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
