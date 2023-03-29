import 'package:http/http.dart';
import 'package:kfone_admin_app_flutter/controller/secure_storage_controller/secure_storage_controller.dart';
import 'package:kfone_admin_app_flutter/ui/pages/home_page/features/devices_page/model/device.dart';
import 'package:kfone_admin_app_flutter/util/model/httpCall.dart';

import '../../util/authorization_config_util.dart';
import '../controller.dart';

class DevicesController extends Controller {
  /// get devices
  static Future<List<Device>> getDevices() async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response =
        await HttpCall.getCall(accessToken!, '$apiBaseUrl/devices');
    if (response.statusCode == 200) {
      return Device.fromJsonList(response.body);
    } else {
      throw Exception('Failed to get devices details');
    }
  }

  /// create device
  static Future<bool> createDevice(Device device) async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.postCall(
      accessToken!,
      '$apiBaseUrl/devices',
      device.toJsonString(),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to add the device');
    }
  }

  /// update device
  static Future<bool> updateDevice(Device device) async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.putCall(
      accessToken!,
      '$apiBaseUrl/devices/${device.id}',
      device.toJsonString(),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to add the device');
    }
  }

  /// delete device
  static Future<bool> deleteDevice(String deviceId) async {
    String apiBaseUrl = await AuthorizationConfigUtil.getAPIBaseUrl();
    String? accessToken = await SecureStorageController.getAccessToken();

    final Response response = await HttpCall.deleteCall(
      accessToken!,
      '$apiBaseUrl/devices/$deviceId',
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete the device');
    }
  }
}
