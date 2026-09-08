import 'package:http/http.dart' as http;

class ConnectionChecker {
  Future<bool> check() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
