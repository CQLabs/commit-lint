import 'dart:io';

import 'package:commit_lint/src/commands/base_command.dart';
import 'package:commit_lint/src/models/commit_issue.dart';
import 'package:commit_lint/src/models/config.dart';
import 'package:commit_lint/src/models/raw_config.dart';
import 'package:commit_lint/src/rules/type/type_rule.dart';
import 'package:commit_lint/src/utils/git_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class LintCommand extends BaseCommand {
  @override
  String get name => 'lint';

  @override
  String get description => '';

  @override
  String get invocation => '';

  LintCommand();

  @override
  void validateCommand() {}

  @override
  Future<void> runCommand() async {
    final commitMessages = [getCommitEditMsg()];

    final rawConfig =
        await RawConfig.rawOptionsFromFilePath(Directory.current.path);
    final configModel = Config.fromRawConfig(rawConfig);

    final rules = [
      TypeRule(configModel.typeConfig),
    ];

    commitMessages.map((commitMessage) {
      if (commitMessage != null) {
        final commit = ConventionalCommit.tryParse(commitMessage);

        if (commit != null) {
          final issues = rules.map((rule) => rule.check(commit));

          return CommitIssue('details', issues);
        }

        return CommitIssue.empty('');
      }
    });

    stdout.writeln('Something went wrong...');

    //TODO(indendial): format output or report output
  }
}
