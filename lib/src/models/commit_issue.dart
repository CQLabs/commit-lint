import 'package:commit_lint/src/models/lint_issue.dart';

class CommitIssue {
  final String details;
  final Iterable<LintIssue> issues;

  const CommitIssue(
    this.details,
    this.issues,
  );

  factory CommitIssue.empty(String details) => CommitIssue(details, []);

  bool get isEmpty => issues.isEmpty;
}
