import 'package:commit_lint/src/models/lint_issue.dart';
import 'package:commit_lint/src/rules/base_rules/case_rule.dart';
import 'package:conventional_commit/conventional_commit.dart';

class SubjectCaseRule extends CaseRule {
  static const _entityType = 'subject';

  SubjectCaseRule(Map<String, Object> config) : super(config, _entityType);

  @override
  LintIssue checkCommit(ConventionalCommit commit) =>
      super.check(commit.description);
}
