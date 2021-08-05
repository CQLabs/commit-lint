import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/rules/base_rules/presence_rule.dart';
import 'package:conventional_commit/conventional_commit.dart';

class ScopePresenceRule extends PresenceRule {
  static const _entityType = 'scope';

  ScopePresenceRule(Map<String, Object> config) : super(config, _entityType);

  @override
  LintIssue checkCommit(ConventionalCommit commit) =>
      super.check(commit.scopes.join(','));
}
