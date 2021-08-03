import 'package:commit_lint/src/models/case_model.dart';

List<String> parseIterable(
  Map<String, Object?> config,
  String key,
  List<String> defaultValues,
) =>
    config[key] is Iterable
        ? List<String>.from(config[key] as Iterable)
        : defaultValues;

bool? parsePresence(Map<String, Object?> config) {
  final raw = config['presence'] as String?;

  if (raw == 'required') {
    return true;
  }

  if (raw == 'omitted') {
    return false;
  }

  if (raw == 'optional') {
    return null;
  }

  return true;
}

String? checkExistence(bool? shouldExist, String? entry, String type) {
  if (shouldExist != null) {
    if (shouldExist && entry == null) {
      return '$type may not be empty';
    }

    if (!shouldExist && entry != null) {
      return '$type must be empty';
    }
  }

  return null;
}

String? checkCase(CaseModel model, String? entry, String type) {
  if (model == CaseModel.lowerCase && entry != null) {
    if (entry.toLowerCase() != entry) {
      return '$type must be lower-case';
    }
  }

  return null;
}

String? checkMinLength(num minLength, String? entry, String type) =>
    _isBelowMinLength(minLength, entry)
        ? '$type must not be shorter than $minLength characters'
        : null;

String? checkMaxLength(num maxLength, String? entry, String type) =>
    _isAboveMaxLength(maxLength, entry)
        ? '$type must not be longer than $maxLength characters'
        : null;

String? checkEntry(
  Iterable<String> allowed,
  Iterable<String> banned,
  String? entry,
  String type,
) {
  if (_isBanned(banned, entry)) {
    return "$type must not be one of [${banned.join(', ')}]";
  } else if (_isNotAllowed(allowed, entry)) {
    return "$type must be one of [${allowed.join(', ')}]";
  }

  return null;
}

bool _isNotAllowed(Iterable<String> allowed, String? entry) =>
    allowed.isNotEmpty && !allowed.contains(entry);

bool _isBanned(Iterable<String> banned, String? entry) =>
    banned.isNotEmpty && banned.contains(entry);

bool _isBelowMinLength(num minLength, String? entry) =>
    entry != null && entry.length < minLength;

bool _isAboveMaxLength(num maxLength, String? entry) =>
    entry != null && entry.length > maxLength;
