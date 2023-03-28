import 'package:flutter/services.dart';

import '../../common.dart';

abstract class ScopeControllerUtil {
  
  /// read the scopes.json file and return the content
  /// [return] [Map<String, dynamic>]
  static Future<Map<String, dynamic>> readScopesJson() async {
    final String config = await rootBundle.loadString('config/scopes.json');
    final Map<String, dynamic>  configJson = Common.jsonDecode(config) ;

    return configJson;
  }
}
