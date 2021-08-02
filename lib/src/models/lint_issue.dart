import 'package:commit_lint/src/models/severity.dart';

class LintIssue {
  final Severity severity;
  final Iterable<String> messages;

  const LintIssue(this.messages, this.severity);
}
