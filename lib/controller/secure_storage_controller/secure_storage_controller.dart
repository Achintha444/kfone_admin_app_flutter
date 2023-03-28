import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../util/authorization_config_util.dart';
import '../../util/controller_util/secure_storage_controller/secure_storage_controller_util.dart';
import '../controller.dart';

class SecureStorageController extends Controller {
  static final FlutterSecureStorage _flutterSecureStorage =
      SecureStorageControllerUtil.getFlutterSecureStorage();

  /// store the access token and id token
  static Future<bool> storeToken(
      AuthorizationTokenResponse authorizationTokenResponse) async {
    String localStorageKeyAccessToken =
        await AuthorizationConfigUtil.getLocalStorageKeyAccessToken();
    String localStorageKeyIdToken =
        await AuthorizationConfigUtil.getLocalStorageKeyIdToken();
    String localStorageKeyAccessTokenExpirationDateTime =
        await AuthorizationConfigUtil
            .getLocalStorageKeyAccessTokenExpirationDateTime();

    try {
      await _flutterSecureStorage.write(
        key: localStorageKeyAccessToken,
        value: authorizationTokenResponse.accessToken,
      );
      await _flutterSecureStorage.write(
        key: localStorageKeyIdToken,
        value: authorizationTokenResponse.idToken,
      );
      await _flutterSecureStorage.write(
        key: localStorageKeyAccessTokenExpirationDateTime,
        value:
            authorizationTokenResponse.accessTokenExpirationDateTime.toString(),
      );

      return true;
    } catch (e) {
      throw Exception('Failed to save the authorization values');
    }
  }

  /// get the access token
  static Future<String?> getAccessToken() async {
    String localStorageKeyAccessToken =
        await AuthorizationConfigUtil.getLocalStorageKeyAccessToken();

    try {
      return _flutterSecureStorage.read(key: localStorageKeyAccessToken);
    } catch (e) {
      throw Exception('Failed to get the access token');
    }
  }

  /// get the id token
  static Future<String?> getIdToken() async {
    String localStorageKeyIdToken =
        await AuthorizationConfigUtil.getLocalStorageKeyIdToken();

    try {
      return _flutterSecureStorage.read(key: localStorageKeyIdToken);
    } catch (e) {
      throw Exception('Failed to get the id token');
    }
  }

  /// get the access token expiration date time
  static Future<String?> getAccessTokenExpirationDateTime() async {
    String localStorageKeyAccessTokenExpirationDateTime =
        await AuthorizationConfigUtil
            .getLocalStorageKeyAccessTokenExpirationDateTime();
    DateTime.now();
    try {
      return _flutterSecureStorage.read(
          key: localStorageKeyAccessTokenExpirationDateTime);
    } catch (e) {
      throw Exception('Failed to get the access token expiration date time');
    }
  }

  /// check if the access token is expired
  static Future<bool> isAccessTokenExpired() async {
    String localStorageKeyAccessTokenExpirationDateTime =
        await AuthorizationConfigUtil
            .getLocalStorageKeyAccessTokenExpirationDateTime();

    try {
      String? accessTokenExpirationDateTimeString = await _flutterSecureStorage
          .read(key: localStorageKeyAccessTokenExpirationDateTime);

      if (accessTokenExpirationDateTimeString == null) {
        return true;
      }

      DateTime accessTokenExpirationDateTime =
          DateTime.parse(accessTokenExpirationDateTimeString);

      return DateTime.now().isAfter(accessTokenExpirationDateTime);
    } catch (e) {
      throw Exception('Failed to check if the access token is expired');
    }
  }

  /// clear local storage
  static Future<void> clearLocalStorage() async {
    try {
      await _flutterSecureStorage.deleteAll();
    } catch (e) {
      throw Exception('Failed to clear local storage');
    }
  }
}
