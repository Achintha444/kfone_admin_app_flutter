import 'package:http/http.dart';
import 'package:kfone_admin_app_flutter/controller/secure_storage_controller/secure_storage_controller.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/promotions_page/model/promotion.dart';
import 'package:kfone_admin_app_flutter/util/model/httpCall.dart';

import '../../util/authorization_config_util.dart';
import '../controller.dart';

class PromotionsController extends Controller {

  /// get user details about the logged in user
  static Future<List<Promotion>> getPromotions() async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.getCall(accessToken!, '$apiBaseUrl/promotions');
    
    if (response.statusCode == 200) {
      return Promotion.fromJsonList(response.body);
    } else {
      throw Exception('Failed to get promotions details');
    }
  }
}
