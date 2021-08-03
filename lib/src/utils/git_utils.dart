import 'dart:io';

import 'package:process_run/cmd_run.dart';
import 'package:path/path.dart';

Future<Iterable<String>> getCommitMessages(String? from, String? to) async =>
    from == null && to == null
        ? _getCommitEditMsg()
        : _getHistoryCommits(from, to);

Future<Iterable<String>> _getHistoryCommits(String? from, String? to) async {
  final gitTo = to ?? 'HEAD';

  final logResult = await runExecutableArguments(
    'git',
    ['log', '--format=%B', from != null ? '$from..$gitTo' : gitTo],
  );

  return (logResult.stdout.trim().split('\n') as Iterable<String>)
      .where((message) => message.trim().isNotEmpty)
      .toList();
}

Future<Iterable<String>> _getCommitEditMsg() async {
  final result = await runExecutableArguments(
    'git',
    ['rev-parse', '--show-toplevel'],
  );

  final rootDirPath = result.stdout.toString().trim();
  final messageFile = File(_uri('$rootDirPath/.git/COMMIT_EDITMSG'));

  if (await messageFile.exists()) {
    return [(await messageFile.readAsString()).trim()];
  }

  return [];
}

String _uri(String filePath) => fromUri(toUri(filePath));
