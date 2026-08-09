import 'package:equatable/equatable.dart';

import '../../home/data/models/coin_model.dart';

class CoinState extends Equatable {
  const CoinState({
    this.coin,
    this.isLoading = false,
  });

  final CoinModel? coin;
  final bool isLoading;

  CoinState copyWith({
    CoinModel? coin,
    bool? isLoading,
  }) {
    return CoinState(
      coin: coin ?? this.coin,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [coin, isLoading];
}
