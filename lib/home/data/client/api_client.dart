import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class ApiClient {
  static const _baseUrl = 'https://api.coingecko.com/api/v3';
  static const _apiKey = 'CG-LrEwdCwhJe6RH1cbFgtot9DG';

  Future<List<dynamic>> get(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    return await _getJson(path, queryParams) as List<dynamic>;
  }

  Future<Map<String, dynamic>> getMap(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    return await _getJson(path, queryParams) as Map<String, dynamic>;
  }

  Future<dynamic> _getJson(
    String path,
    Map<String, String>? queryParams,
  ) async {
    final url = _buildUrl(path, queryParams);
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw HttpException(
        'CoinGecko API вернул ошибку ${response.statusCode}: ${response.body}',
        uri: url,
      );
    }
    return jsonDecode(response.body);
  }

  Uri _buildUrl(String path, Map<String, String>? queryParams) {
    return Uri.parse(
      '$_baseUrl$path',
    ).replace(queryParameters: {...?queryParams, 'x_cg_demo_api_key': _apiKey});
  }
}
