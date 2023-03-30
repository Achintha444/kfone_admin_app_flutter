import "dart:developer";

import "package:flutter_appauth/flutter_appauth.dart";
import "package:kfone_admin_app_flutter/controller/scopes_controller/scope_controller.dart";
import "package:kfone_admin_app_flutter/util/model/session_token.dart";

import "../../util/authorization_config_util.dart";
import "../../util/controller_util/login_controller/login_controller_util.dart";
import "../controller.dart";

class LoginController extends Controller {
  static final FlutterAppAuth _flutterAppAuth =
      LoginControllerUtil.getFlutterAppAuthObject();

  /// login function
  static Future<AuthorizationTokenResponse?> loginAction() async {
    final String clinetId = await AuthorizationConfigUtil.getClientId();
    final List<String> scopes = await AuthorizationConfigUtil.getScopes();
    final String discoveryUrl = await AuthorizationConfigUtil.getDiscoveryUrl();
    final String redirectUrl = await AuthorizationConfigUtil.getRedirectUrl();

    try {
      // add the all the scopes that is related to other interfaces
      scopes.addAll( await ScopeController.getAllScopesOfInterfaces());

      final AuthorizationTokenResponse? result =
          await _flutterAppAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          clinetId,
          redirectUrl,
          discoveryUrl: discoveryUrl,
          scopes: scopes,
          preferEphemeralSession: true
        ),
      );

      inspect(result);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// logout function
  static Future<EndSessionResponse?> logoutAction(
      SessionToken sessionToken) async {
    final String discoveryUrl = await AuthorizationConfigUtil.getDiscoveryUrl();
    final String redirectUrl = await AuthorizationConfigUtil.getRedirectUrl();

    try {
      final EndSessionResponse? result = await _flutterAppAuth.endSession(
        EndSessionRequest(
          idTokenHint:
              AuthorizationConfigUtil.getIdToken(sessionToken),
          postLogoutRedirectUrl: redirectUrl,
          discoveryUrl: discoveryUrl,
        ),
      );

      inspect(result);

      return result;
    } catch (e, s) {
      inspect("logout error: $e - stack: $s");
      throw Exception("Failed to logout");
    }
  }
}
