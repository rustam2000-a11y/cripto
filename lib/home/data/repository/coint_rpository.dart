import 'package:injectable/injectable.dart';
import '../api/coint_api.dart';
import '../models/coin_model.dart';


@LazySingleton(as: CointRepositoryI)

class CointRepository extends CointRepositoryI{
  CointRepository({ required CoinApI api}): _api = api;
  final CoinApI _api;
  @override
  Future<List<CoinModel>> fetch(){
    return _api.fetch();
  }
}

abstract class CointRepositoryI{
  Future<List<CoinModel>> fetch();

}