import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypePresenceRule extends LintRule {
  static const String ruleId = 'type-presence';

  final TypePresenceConfig _config;

  TypePresenceRule(Map<String, Object> config)
      : _config = TypePresenceConfig.fromConfigMap(config),
        super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) => LintIssue(
        checkExistence(_config.shouldExist, commit.type, 'type'),
        _config.severity,
      );
}

class TypePresenceConfig {
  final bool? shouldExist;

  final Severity severity;

  const TypePresenceConfig._({
    required this.shouldExist,
    required this.severity,
  });

  factory TypePresenceConfig.fromConfigMap(Map<String, Object> rawLintConfig) {
    final config = rawLintConfig[TypePresenceRule.ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return TypePresenceConfig._(
      shouldExist: parsePresence(configMap),
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
