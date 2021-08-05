import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';

abstract class EnumRule extends LintRule {
  final String _type;
  final _EnumConfig _config;

  EnumRule(Map<String, Object> config, this._type)
      : _config = _EnumConfig.fromConfigMap(config, '$_type-enum'),
        super(id: '$_type-enum');

  @override
  LintIssue check(String? content) => LintIssue(
        _config.isEnabled
            ? checkEntry(_config.allowed, _config.banned, content, _type)
            : null,
        _config.severity,
      );
}

class _EnumConfig {
  final Iterable<String> allowed;
  final Iterable<String> banned;

  final Severity severity;
  final bool isEnabled;

  const _EnumConfig._({
    required this.allowed,
    required this.banned,
    required this.severity,
    required this.isEnabled,
  });

  factory _EnumConfig.fromConfigMap(
    Map<String, Object> rawLintConfig,
    String ruleId,
  ) {
    final config = rawLintConfig[ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return _EnumConfig._(
      isEnabled: rawLintConfig.containsKey(ruleId),
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
