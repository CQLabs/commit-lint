import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypeEnumRule extends LintRule {
  static const String ruleId = 'type-enum';

  final TypeEnumConfig _config;

  TypeEnumRule(Map<String, Object> config)
      : _config = TypeEnumConfig.fromConfigMap(config),
        super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) => LintIssue(
        checkEntry(_config.allowed, _config.banned, commit.type, 'type'),
        _config.severity,
      );
}

class TypeEnumConfig {
  final Iterable<String> allowed;
  final Iterable<String> banned;

  final Severity severity;

  const TypeEnumConfig._({
    required this.allowed,
    required this.banned,
    required this.severity,
  });

  factory TypeEnumConfig.fromConfigMap(Map<String, Object> rawLintConfig) {
    final config = rawLintConfig[TypeEnumRule.ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return TypeEnumConfig._(
      allowed: parseIterable(
        configMap,
        'allowed',
        ['feat', 'fix', 'docs', 'style', 'refactor', 'test', 'revert'],
      ),
      banned: parseIterable(configMap, 'banned', []),
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
