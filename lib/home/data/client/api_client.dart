import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class ApiClient {
  static const _baseUrl = 'https://api.coingecko.com/api/v3';

  Future<List<dynamic>> get(String path, {Map<String, String>? queryParams}) async {
    final url = Uri.parse(
      '$_baseUrl$path',
    ).replace(queryParameters: queryParams);
    final response = await http.get(url);
    final decode = jsonDecode(response.body);
    return decode;
  }

  Future<Map<String, dynamic>> getMap(String path, {Map<String, String>? queryParams}) async {
    final url = Uri.parse(
      '$_baseUrl$path',
    ).replace(queryParameters: queryParams);
    final response = await http.get(url);
    final decode = jsonDecode(response.body);
    return decode as Map<String, dynamic>;
  }
}
