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

  /// common authroization call
  static Future<http.Response> postCall(
      String accessToken, String url, Object body) async {
    final response = await http.post(
      Uri.parse(
        url,
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      body: body,
    );

    return response;
  }

  /// common authroization call
  static Future<http.Response> patchCall(
      String accessToken, String url, Object body) async {
    final response = await http.patch(
      Uri.parse(
        url,
      ),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      },
      body: body,
    );

    return response;
  }
}
