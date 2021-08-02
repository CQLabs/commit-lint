import 'package:args/command_runner.dart';

// import 'package:io/io.dart'; TODO: use

import 'commands/lint.dart';

class CliRunner extends CommandRunner<void> {
  static final _commands = [
    LintCommand(),
  ];

  CliRunner()
      : super(
          'commit-lint',
          '',
        ) {
    _commands.forEach(addCommand);
  }

  @override
  String get invocation => '${super.invocation}';

  @override
  Future<void> run(Iterable<String> args) async {
    await super.run(_addDefaultCommand(args));
  }

  Iterable<String> _addDefaultCommand(Iterable<String> args) => args.isEmpty
      ? args
      : !commands.keys.contains(args.first)
          ? ['lint', ...args]
          : args;
}
