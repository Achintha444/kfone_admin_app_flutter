import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageControllerUtil {
  static const FlutterSecureStorage _flutterSecureStorage = FlutterSecureStorage();

  /// get the [FlutterSecureStorage] object
  static FlutterSecureStorage getFlutterSecureStorage() {
    return _flutterSecureStorage;
  }
}
