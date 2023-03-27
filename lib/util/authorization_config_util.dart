
import 'package:flutter/services.dart';
import 'package:kfone_admin_app_flutter/util/model/session_token.dart';

import './common.dart';

abstract class AuthorizationConfigUtil {

  /// read the config.json file and return the content
  /// [return] [Map<String, dynamic>]
  static Future<Map<String, dynamic>> _readConfigJson() async {
    final String config = await rootBundle.loadString('config/config.json');
    final Map<String, dynamic> configJson = Common.jsonDecode(config);

    return configJson;
  }

  /// get the base organization url
  static Future<String> getBaseOrganizationUrl() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["AuthorizationConfig"]["BaseOrganizationUrl"];
  }

  /// get the client id
  static Future<String> getClientId() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["AuthorizationConfig"]["ClientId"];
  }

  /// get the scopes
  static Future<List<String>> getScopes() async {
    final Map<String, dynamic> configJson = await _readConfigJson();

    return List<String>.from(configJson["AuthorizationConfig"]["Scopes"]);
  }

  /// get the redirect url
  static Future<String> getRedirectUrl() async{
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["LoginCallbackUrl"];
  }

  /// get the discovery url
  static Future<String> getDiscoveryUrl() async {
    String baseUrl = await getBaseOrganizationUrl();

    return "$baseUrl/oauth2/token/.well-known/openid-configuration";
  }

  /// get the logout url
  static Future<String> getLogoutUrl() async {
    String baseUrl = await getBaseOrganizationUrl();

    return "$baseUrl/oidc/logout";
  }

  /// get the access token from the `SessionToken`
  static String getAccessToken(
      SessionToken sessionToken) {
    String? accessToken = sessionToken.accessToken;

    if (accessToken == null) {
      return "";
    }

    return accessToken;
  }

  /// get the ID token from the `SessionToken`
  static String getIdToken(
      SessionToken sessionToken) {
    String? idToken = sessionToken.idToken;

    if (idToken == null) {
      return "";
    }

    return idToken;
  }

  /// get the access token expiration date time from the `SessionToken`
  static DateTime getAccessTokenExpirationDateTime(
      SessionToken sessionToken) {
    DateTime? accessTokenExpirationDateTime =
        sessionToken.accessTokenExpirationDateTime;

    if (accessTokenExpirationDateTime == null) {
      return DateTime.now();
    }

    return accessTokenExpirationDateTime;
  }

  /// get the local storage key to locally store the access token
  static Future<String> getLocalStorageKeyAccessToken() async{
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["LocalStoreKey"]["AccessToken"];
  }

  /// get the local storage key to locally store the id token
  static Future<String> getLocalStorageKeyIdToken() async{
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["LocalStoreKey"]["IdToken"];
  }

  /// get the local storage key to locally store the access token expiration date time
  static Future<String> getLocalStorageKeyAccessTokenExpirationDateTime() async{
    final Map<String, dynamic> configJson = await _readConfigJson();

    return configJson["LocalStoreKey"]["AccessTokenExpirationDateTime"];
  }
}
