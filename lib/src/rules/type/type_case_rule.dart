import 'package:commit_lint/src/models/case_model.dart';
import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypeCaseRule extends LintRule {
  static const String ruleId = 'type-case';

  final TypeCaseConfig _config;

  TypeCaseRule(Map<String, Object> config)
      : _config = TypeCaseConfig.fromConfigMap(config),
        super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) => LintIssue(
        checkCase(_config.caseModel, commit.type, 'type'),
        _config.severity,
      );
}

class TypeCaseConfig {
  final CaseModel caseModel;

  final Severity severity;

  const TypeCaseConfig._({
    required this.caseModel,
    required this.severity,
  });

  static TypeCaseConfig fromConfigMap(Map<String, Object> rawLintConfig) {
    final config = rawLintConfig[TypeCaseRule.ruleId];
    final configMap =
        config is Map<String, Object?> ? config : <String, Object?>{};

    return TypeCaseConfig._(
      caseModel: CaseModel.parse(
            configMap['case'] as String?,
          ) ??
          CaseModel.lowerCase,
      severity: Severity.fromConfig(configMap, Severity.error),
    );
  }
}
