import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/rules/base_rules/min_length_rule.dart';
import 'package:conventional_commit/conventional_commit.dart';

class ScopeMinLengthRule extends MinLengthRule {
  static const _entityType = 'scope';

  ScopeMinLengthRule(Map<String, Object> config) : super(config, _entityType);

  @override
  LintIssue checkCommit(ConventionalCommit commit) =>
      super.check(commit.scopes.join(','));
}
