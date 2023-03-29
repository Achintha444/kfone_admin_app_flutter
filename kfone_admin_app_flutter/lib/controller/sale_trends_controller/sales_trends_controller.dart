import 'package:http/http.dart';
import 'package:kfone_admin_app_flutter/controller/secure_storage_controller/secure_storage_controller.dart';
import 'package:kfone_admin_app_flutter/util/model/httpCall.dart';

import '../../util/authorization_config_util.dart';
import '../controller.dart';

class SalesTrendsController extends Controller {

  /// get user details about the logged in user
  static Future<bool> getSalesTrends() async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.getCall(accessToken!, '$apiBaseUrl/sales_trends');
    
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to get sales trends details');
    }
  }
}
