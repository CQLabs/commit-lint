import 'dart:io';
import 'dart:isolate';

import 'package:commit_lint/src/utils/raw_config_utils.dart';
import 'package:commit_lint/src/utils/yaml_utils.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Class representing raw config
@immutable
class RawConfig {
  static const _configFileName = 'commit_lint.yaml';

  final Map<String, Object> config;

  const RawConfig(this.config);

  Map<String, Object> readMap(Iterable<String> pathSegments) {
    Object? data = config;

    for (final key in pathSegments) {
      if (data is Map<String, Object?> && data.containsKey(key)) {
        data = data[key];
      } else {
        return {};
      }
    }

    return data is Map<String, Object> ? data : {};
  }

  static Future<RawConfig> rawOptionsFromFilePath(String path) {
    final analysisOptionsFile = File(p.absolute(path, _configFileName));

    return rawOptionsFromFile(analysisOptionsFile);
  }

  static Future<RawConfig> rawOptionsFromFile(File? options) async =>
      options != null && options.existsSync()
          ? RawConfig(await _loadConfigFromYamlFile(options))
          : const RawConfig({});

  static Future<Map<String, Object>> _loadConfigFromYamlFile(
    File options,
  ) async {
    try {
      final node = options.existsSync()
          ? loadYamlNode(options.readAsStringSync())
          : YamlMap();

      var optionsNode =
          node is YamlMap ? yamlMapToDartMap(node) : <String, Object>{};

      final includeNode = optionsNode['include'];
      if (includeNode is String) {
        final resolvedUri = includeNode.startsWith('package:')
            ? await Isolate.resolvePackageUri(Uri.parse(includeNode))
            : Uri.file(p.absolute(p.dirname(options.path), includeNode));
        if (resolvedUri != null) {
          final resolvedYamlMap =
              await _loadConfigFromYamlFile(File.fromUri(resolvedUri));
          optionsNode =
              mergeMaps(defaults: resolvedYamlMap, overrides: optionsNode);
        }
      }

      return optionsNode;
    } on YamlException catch (e) {
      throw FormatException(e.message, e.span);
    }
  }
}
