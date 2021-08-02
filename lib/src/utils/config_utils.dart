List<String> parseIterable(
  Map<String, Object> config,
  String key,
  List<String> defaultValues,
) =>
    config[key] is Iterable
        ? List<String>.from(config[key] as Iterable)
        : defaultValues;

bool? parsePresence(Map<String, Object> config) {
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
