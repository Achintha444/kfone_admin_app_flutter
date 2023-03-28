import 'package:kfone_admin_app_flutter/util/controller_util/scope_controller/scope_controller_util.dart';

import '../controller.dart';

class ScopeController extends Controller {
  /// get all the scopes related of all the interfaces
  static Future<List<String>> getAllScopesOfInterfaces() async {
    List<dynamic> scopes = [];
    final Map<String, dynamic> scopeJson =
        await ScopeControllerUtil.readScopesJson();
    scopeJson.forEach((key, value) {
      scopes.addAll(value["scopes"]);
    });

    return List<String>.from(scopes);
  }

  /// get all the scopes of the device interface
  static Future<List<String>> getAllScopesOfDeviceInterface() async {
    final Map<String, dynamic> scopeJson =
        await ScopeControllerUtil.readScopesJson();

    return List<String>.from(scopeJson["DevicesInterface"]["scopes"]);
  }

  /// get all the scopes of the device interface
  static Future<List<String>> getAllScopesOfPermissionsInterface() async {
    final Map<String, dynamic> scopeJson =
        await ScopeControllerUtil.readScopesJson();

    return List<String>.from(scopeJson["PermissionsInterface"]["scopes"]);
  }

  /// get all the scopes of the device interface
  static Future<List<String>> getAllScopesOfSalesTrendsInterface() async {
    final Map<String, dynamic> scopeJson =
        await ScopeControllerUtil.readScopesJson();

    return List<String>.from(scopeJson["SalesTrendsInterface"]["scopes"]);
  }
}
