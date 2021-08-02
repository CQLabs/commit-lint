import 'dart:io';

import 'package:path/path.dart';

String? getCommitEditMsg() {
  final rootDir = Directory.current;
  final messageFile = File(_uri('${rootDir.path}/.git/COMMIT_EDITMSG'));

  if (messageFile.existsSync()) {
    return messageFile.readAsStringSync();
  }

  return null;
}

String _uri(String filePath) => fromUri(toUri(filePath));
