import 'package:commit_lint/src/models/case_model.dart';
import 'package:commit_lint/src/models/severity.dart';
import 'package:commit_lint/src/utils/config_utils.dart';

class TypeConfig {
  final bool? shouldExist;
  final num minLength;
  final num maxLength;
  final CaseModel caseModel;
  final Iterable<String> allowed;
  final Iterable<String> banned;

  final Severity severity;

  const TypeConfig._({
    required this.shouldExist,
    required this.minLength,
    required this.maxLength,
    required this.caseModel,
    required this.allowed,
    required this.banned,
    required this.severity,
  });

  factory TypeConfig.fromConfigMap(Map<String, Object> config) {
    final shouldExist = parsePresence(config);

    final minLength = config['min-length'] as int? ?? 0;
    final maxLength = config['max-length'] as int? ?? double.infinity;

    final allowed = parseIterable(
      config,
      'allowed',
      ['feat', 'fix', 'docs', 'style', 'refactor', 'test', 'revert'],
    );

    final banned = parseIterable(config, 'banned', []);

    final caseModel =
        CaseModel.parse(config['case'] as String?) ?? CaseModel.lowerCase;

    return TypeConfig._(
      shouldExist: shouldExist,
      minLength: minLength,
      maxLength: maxLength,
      caseModel: caseModel,
      allowed: allowed,
      banned: banned,
      severity: Severity.fromConfig(config, Severity.error),
    );
  }
}
