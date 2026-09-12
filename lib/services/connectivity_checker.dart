import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:http/http.dart' as http;

class ConnectionChecker {
  Future<bool> check() async {
    try {
      final response = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 5));
      print('Connected');
      return response.statusCode == 200;
    } catch (e) {
      print('Disconnected');
      return false;
    }
  }

  void listen(Future<void> Function() onConnected) async {
    Connectivity().onConnectivityChanged.listen((result) async {
      final connected = await check();
      if (connected) {
        onConnected();
      }
    });
  }
}
