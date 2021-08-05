import 'package:commit_lint/src/models/case_model.dart';
import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';

abstract class CaseRule extends LintRule {
  final String _type;
  final _CaseConfig _config;

  CaseRule(Map<String, Object> config, this._type)
      : _config = _CaseConfig.fromConfigMap(config, '$_type-case'),
        super(id: '$_type-case');

  @override
  LintIssue check(String? content) => LintIssue(
        _config.isEnabled ? checkCase(_config.caseModel, content, _type) : null,
        _config.severity,
      );
}

class _CaseConfig {
  final CaseModel caseModel;

  final Severity severity;
  final bool isEnabled;

  const _CaseConfig._({
    required this.caseModel,
    required this.severity,
    required this.isEnabled,
  });

  static _CaseConfig fromConfigMap(
      Map<String, Object> rawLintConfig, String ruleId) {
    final config = rawLintConfig[ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return _CaseConfig._(
      isEnabled: rawLintConfig.containsKey(ruleId),
      caseModel: CaseModel.parse(
            configMap['case'] as String?,
          ) ??
          CaseModel.lowerCase,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
