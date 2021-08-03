import 'dart:io';

// import 'package:io/io.dart';
import 'package:collection/collection.dart';
import 'package:commit_lint/src/commands/base_command.dart';
import 'package:commit_lint/src/models/commit_issue.dart';
import 'package:commit_lint/src/models/config.dart';
import 'package:commit_lint/src/models/raw_config.dart';
import 'package:commit_lint/src/rules/type/type_case_rule.dart';
import 'package:commit_lint/src/rules/type/type_enum_rule.dart';
import 'package:commit_lint/src/rules/type/type_max_length_rule.dart';
import 'package:commit_lint/src/rules/type/type_min_length_rule.dart';
import 'package:commit_lint/src/rules/type/type_presence_rule.dart';
import 'package:commit_lint/src/utils/git_utils.dart';
import 'package:conventional_commit/conventional_commit.dart';

class LintCommand extends BaseCommand {
  @override
  String get name => 'lint';

  @override
  String get description => 'Lint your commit messages. ';

  @override
  String get invocation => '${runner.executableName} $name';

  LintCommand() {
    argParser
      ..addSeparator('')
      ..addOption(
        'from',
        abbr: 'f',
        help: 'Lower end of the commit range to lint.',
      )
      ..addOption(
        'to',
        abbr: 't',
        help: 'Upper end of the commit range to lint.',
      )
      ..addSeparator('')
      ..addFlag(
        'print-config',
        abbr: 'c',
        help: 'Print resolved config.',
        negatable: false,
      )
      ..addFlag(
        'verbose',
        abbr: 'V',
        help: 'Print verbose output.',
        negatable: false,
        callback: (verbose) {
          // if (verbose) {
          //   logger = Logger.verbose();
          // } else {
          //   logger = Logger.standard();
          // }
        },
      );
  }

  @override
  void validateCommand() {}

  @override
  Future<void> runCommand() async {
    final fromCommit = argResults['from'] as String?;
    final toCommit = argResults['to'] as String?;

    final commitMessages = await getCommitMessages(fromCommit, toCommit);

    final rawConfig =
        await RawConfig.rawOptionsFromFilePath(Directory.current.path);
    final configModel = Config.fromRawConfig(rawConfig);

    final rules = [
      TypeCaseRule(configModel.lintConfig),
      TypeEnumRule(configModel.lintConfig),
      TypeMinLengthRule(configModel.lintConfig),
      TypeMaxLengthRule(configModel.lintConfig),
      TypePresenceRule(configModel.lintConfig),
    ];

    final commitIssues = commitMessages
        .map((commitMessage) {
          print(commitMessage);

          final commit = ConventionalCommit.tryParse(commitMessage);

          if (commit != null) {
            final issues = rules.map((rule) => rule.check(commit));

            return CommitIssue('details', issues);
          }

          return null;
        })
        .whereNotNull()
        .toList();

    if (commitIssues.isNotEmpty) {
      commitIssues.forEach(
        (commits) => commits.issues.forEach((issue) {
          if (issue.message != null) print(issue.message);
        }),
      );

      return;
    }

    stdout.writeln('Something went wrong...');

    //TODO(indendial): format output or report output
  }
}
