import 'package:collection/collection.dart';
import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/rules/type/type_config.dart';
import 'package:commit_lint/src/utils/rule_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class TypeRule extends LintRule {
  static const String ruleId = 'type';

  final TypeConfig _config;

  const TypeRule(this._config) : super(id: ruleId);

  @override
  LintIssue check(ConventionalCommit commit) {
    final messages = <String>[];

    final existenceMessage = checkExistence(
      _config.shouldExist,
      commit.type,
      ruleId,
    );
    if (existenceMessage != null) {
      messages.add(existenceMessage);

      return LintIssue(messages, _config.severity);
    }

    messages.addAll([
      checkEntry(
        _config.allowed,
        _config.banned,
        commit.type,
        ruleId,
      ),
      checkLength(
        _config.minLength,
        _config.minLength,
        commit.type,
        ruleId,
      ),
      checkCase(
        _config.caseModel,
        commit.type,
        ruleId,
      )
    ].whereNotNull());

    return LintIssue(messages, _config.severity);
  }
}
