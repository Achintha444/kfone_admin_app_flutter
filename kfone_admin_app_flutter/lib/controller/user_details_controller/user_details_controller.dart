import 'dart:convert';

import 'package:http/http.dart';
import 'package:kfone_admin_app_flutter/controller/secure_storage_controller/secure_storage_controller.dart';
import 'package:kfone_admin_app_flutter/util/model/httpCall.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import '../../model/user.dart';
import '../../util/authorization_config_util.dart';
import '../../util/controller_util/user_details_controller/user_details_controller_util.dart';
import '../controller.dart';

class UserDetailsController extends Controller {
  /// update user details of the logged in user
  static Future<bool> updateUserDetails(
      String id, String fullNameTextField) async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.patchCall(
      accessToken!,
      '$apiBaseUrl/update/$id',
      jsonEncode({"full_name": fullNameTextField}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to update the user');
    }
  }

  /// get user details about the logged in user
  static Future<User> getUserDetails(SessionToken sessionToken) async {
    String userinfoUrl = await UserDetailsControllerUtil.getUserIntoUrl();
    String accessToken = AuthorizationConfigUtil.getAccessToken(sessionToken);

    final Response response = await HttpCall.getCall(accessToken, userinfoUrl);
    if (response.statusCode == 200) {
      return User.fromJsonString(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }

  /// get the scopes of the user
  static Future<List<String>> getUserScopes() async {
    String? accessToken = await SecureStorageController.getAccessToken();
    Map<String, dynamic> accessTokenObject =
        AuthorizationConfigUtil.decodeAccessToken(accessToken);

    if (accessTokenObject != {}) {
      String scopes = accessTokenObject["scope"];
      return scopes.split(" ");
    }

    return [];
  }
}
