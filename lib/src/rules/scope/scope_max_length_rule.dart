import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/rules/base_rules/max_length_rule.dart';
import 'package:conventional_commit/conventional_commit.dart';

class ScopeMaxLengthRule extends MaxLengthRule {
  static const _entityType = 'scope';

  ScopeMaxLengthRule(Map<String, Object> config) : super(config, _entityType);

  @override
  LintIssue checkCommit(ConventionalCommit commit) =>
      super.check(commit.scopes.join(','));
}
