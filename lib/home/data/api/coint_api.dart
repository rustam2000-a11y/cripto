
import 'package:injectable/injectable.dart';

import '../client/api_client.dart';
import '../models/coin_model.dart';
import '../models/price_point.dart';

@Injectable(as: CoinApI)
class CoinApi extends CoinApI {
  final ApiClient _client;

  CoinApi(this._client);

  @override
  Future<List<CoinModel>> fetch() async {
    final data = await _client.get(
      '/coins/markets',
      queryParams: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': '250',
        'page': '1',
      },
    );
    final coins = data.map((d)=> CoinModel.fromJson(d)).toList();
    return coins;
  }

  @override
  Future<CoinModel> fetchById(String id) async {
    final data = await _client.get(
      '/coins/markets',
      queryParams: {
        'vs_currency': 'usd',
        'ids': id,
      },
    );
    return CoinModel.fromJson(data.first);
  }

  @override
  Future<List<PricePoint>> fetchMarketChart(String id, {int days = 7}) async {
    final data = await _client.getMap(
      '/coins/$id/market_chart',
      queryParams: {
        'vs_currency': 'usd',
        'days': '$days',
      },
    );
    final prices = data['prices'] as List<dynamic>;
    return prices
        .map((p) => PricePoint.fromJson(p as List<dynamic>))
        .toList();
  }
}

abstract class CoinApI {
  Future<List<CoinModel>> fetch();
  Future<CoinModel> fetchById(String id);
  Future<List<PricePoint>> fetchMarketChart(String id, {int days = 7});
}
