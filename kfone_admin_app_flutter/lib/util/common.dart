import 'dart:convert';

abstract class Common {
  /// Decode JSON from a json string
  static Map<String, dynamic> jsonDecode(String jsonString) {
    return json.decode(jsonString);
  }
}
