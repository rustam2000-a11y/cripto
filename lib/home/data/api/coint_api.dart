import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../models/coin_model.dart';

@injectable
class CoinApi extends CoinApI {
  @override
  Future<List<CoinModel>> fetch() async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1',
    );
    final response = await http.get(url);
    final decode = jsonDecode(response.body);
    final coins = decode.map((e) => CoinModel.fromJson(e)).toList();
    return coins;
  }
}

abstract class CoinApI {
  Future<List<CoinModel>> fetch();
}
