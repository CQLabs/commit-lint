import 'package:commit_lint/src/models/severity.dart';

class LintIssue {
  final Severity severity;
  final String? message;

  const LintIssue(this.message, this.severity);
}
