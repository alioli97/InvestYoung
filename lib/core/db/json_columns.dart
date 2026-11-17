import 'dart:convert';

/// Encodes a JSON object column (`params_json`, `metadata_json`).
String encodeJsonMap(Map<String, Object?> map) => jsonEncode(map);

/// Decodes a JSON object column; returns an empty map for blank values.
Map<String, Object?> decodeJsonMap(String json) {
  if (json.trim().isEmpty) return const {};
  return (jsonDecode(json) as Map).cast<String, Object?>();
}
