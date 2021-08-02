import 'package:args/args.dart';
import 'package:args/command_runner.dart';
import 'package:meta/meta.dart';

abstract class BaseCommand extends Command<void> {
  @override
  ArgResults get argResults {
    if (super.argResults == null) {
      throw StateError('Unexpected empty args parse result');
    }

    return super.argResults!;
  }

  @override
  CommandRunner get runner => super.runner as CommandRunner;

  @override
  Future<void> run() => _verifyThenRunCommand();

  @protected
  void validateCommand();

  @protected
  Future<void> runCommand();

  Future<void> _verifyThenRunCommand() async {
    return runCommand();
  }
}
