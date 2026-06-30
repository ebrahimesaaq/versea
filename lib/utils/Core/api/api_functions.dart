import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:versea/utils/Core/api/api_services.dart';

class ApiFunctions {
  Future<Map<String, dynamic>> getChaptersFunction() async {
    final response = await http.get(
      Uri.parse('${ApiServices.apiReference}json/chapters'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    print(response.statusCode);
    print(response.body);

    throw Exception('Failed');
  }

  Future<Map<String, dynamic>> getBooksFunction() async {
    final response = await http.get(
      Uri.parse('${ApiServices.apiReference}json/books'),
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    print(response.statusCode);
    print(response.body);

    throw Exception('Failed');
  }
}
