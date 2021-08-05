import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/rules/base_rules/enum_rule.dart';
import 'package:conventional_commit/conventional_commit.dart';

class ScopeEnumRule extends EnumRule {
  static const _entityType = 'scope';

  ScopeEnumRule(Map<String, Object> config) : super(config, _entityType);

  @override
  LintIssue checkCommit(ConventionalCommit commit) =>
      super.check(commit.scopes.join(','));
}
