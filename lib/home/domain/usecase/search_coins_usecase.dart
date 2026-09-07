import 'package:injectable/injectable.dart';

import '../../data/models/coin_model.dart';

@injectable
class SearchCoinsUseCase {
  List<CoinModel> call(List<CoinModel> coins, String query) {
    if (query.isEmpty) return coins;
    final lowerQuery = query.toLowerCase();
    return coins
        .where(
          (coin) =>
              coin.name.toLowerCase().contains(lowerQuery) ||
              coin.symbol.toLowerCase().contains(lowerQuery),
        )
        .toList();
  }
}
