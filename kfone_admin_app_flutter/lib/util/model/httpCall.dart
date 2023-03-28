// ignore: file_names
import 'package:http/http.dart' as http;

abstract class HttpCall {

  /// common authroization call
  static Future<http.Response> getCall(String accessToken, String url) async {
    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
    );

    return response;
  }
}