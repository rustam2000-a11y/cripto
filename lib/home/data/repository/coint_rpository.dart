import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';
import '../api/coint_api.dart';
import '../models/coin_model.dart';

@LazySingleton(as: CoinRepositoryI)
class CoinRepository extends CoinRepositoryI {
  CoinRepository({required CoinApI api}) : _api = api;

  final CoinApI _api;

  @override
  Stream<List<CoinModel>> watchCoins() {
    return Stream.periodic(const Duration(seconds: 60))
        .startWith(null)
        .switchMap((_) => Stream.fromFuture(_api.fetch()));
  }
}

abstract class CoinRepositoryI {
  Stream<List<CoinModel>> watchCoins();
}