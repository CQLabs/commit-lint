import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';

abstract class PresenceRule extends LintRule {
  final String _type;
  final _PresenceConfig _config;

  PresenceRule(Map<String, Object> config, this._type)
      : _config = _PresenceConfig.fromConfigMap(config, '$_type-presence'),
        super(id: '$_type-presence');

  @override
  LintIssue check(String? content) => LintIssue(
        _config.isEnabled
            ? checkExistence(_config.shouldExist, content, _type)
            : null,
        _config.severity,
      );
}

class _PresenceConfig {
  final bool? shouldExist;

  final Severity severity;
  final bool isEnabled;

  const _PresenceConfig._({
    required this.shouldExist,
    required this.severity,
    required this.isEnabled,
  });

  factory _PresenceConfig.fromConfigMap(
      Map<String, Object> rawLintConfig, String ruleId) {
    final config = rawLintConfig[ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return _PresenceConfig._(
      isEnabled: rawLintConfig.containsKey(ruleId),
      shouldExist: parsePresence(configMap),
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
