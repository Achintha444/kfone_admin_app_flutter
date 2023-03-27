
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:http/http.dart';

import '../../model/user.dart';
import '../../util/authorization_config_util.dart';
import '../../util/common.dart';
import '../../util/controller_util/user_details_controller/user_details_controller_util.dart';
import '../controller.dart';

class UserDetailsController extends Controller {

  /// get user details about the logged in user
  static Future<User> getUserDetails(AuthorizationTokenResponse authorizationTokenResponse) async {
    String userinfoUrl = await UserDetailsControllerUtil.getUserIntoUrl();
    String accessToken = AuthorizationConfigUtil.getAccessToken(authorizationTokenResponse);

    final Response response = await Common.getCall(accessToken, userinfoUrl);

    if (response.statusCode == 200) {
      return User.fromJsonString(response.body);
    } else {
      throw Exception('Failed to get user details');
    }
  }
}
