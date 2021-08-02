import 'package:collection/collection.dart';

class CaseModel {
  final String name;

  const CaseModel._(this.name);

  static final lowerCase = CaseModel._('lower-case');

  static final cases = [
    lowerCase,
  ];

  static CaseModel? parse(String? name) =>
      cases.firstWhereOrNull((model) => model.name == name);
}
