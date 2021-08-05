import 'package:commit_lint/src/models/lint_rule.dart';
import 'package:commit_lint/src/rules/scope/scope_case_rule.dart';
import 'package:commit_lint/src/rules/scope/scope_enum_rule.dart';
import 'package:commit_lint/src/rules/scope/scope_max_length_rule.dart';
import 'package:commit_lint/src/rules/scope/scope_min_length_rule.dart';
import 'package:commit_lint/src/rules/scope/scope_presence_rule.dart';
import 'package:commit_lint/src/rules/subject/subject_case_rule.dart';
import 'package:commit_lint/src/rules/subject/subject_max_length_rule.dart';
import 'package:commit_lint/src/rules/subject/subject_min_length_rule.dart';
import 'package:commit_lint/src/rules/subject/subject_presence_rule.dart';
import 'package:commit_lint/src/rules/type/type_case_rule.dart';
import 'package:commit_lint/src/rules/type/type_enum_rule.dart';
import 'package:commit_lint/src/rules/type/type_max_length_rule.dart';
import 'package:commit_lint/src/rules/type/type_min_length_rule.dart';
import 'package:commit_lint/src/rules/type/type_presence_rule.dart';

Iterable<LintRule> getRules(Map<String, Object> lintConfig) => [
      // Type
      TypeCaseRule(lintConfig),
      TypeEnumRule(lintConfig),
      TypeMinLengthRule(lintConfig),
      TypeMaxLengthRule(lintConfig),
      TypePresenceRule(lintConfig),
      // Scope
      ScopeCaseRule(lintConfig),
      ScopeEnumRule(lintConfig),
      ScopeMinLengthRule(lintConfig),
      ScopeMaxLengthRule(lintConfig),
      ScopePresenceRule(lintConfig),
      // Subject
      SubjectCaseRule(lintConfig),
      SubjectMinLengthRule(lintConfig),
      SubjectMaxLengthRule(lintConfig),
      SubjectPresenceRule(lintConfig),
    ];
