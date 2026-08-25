import 'package:equatable/equatable.dart';

import '../../home/data/models/coin_model.dart';

class BriefcaseState extends Equatable {
  const BriefcaseState({this.coins = const [], this.isLoading = false});

  final List<CoinModel> coins;
  final bool isLoading;

  BriefcaseState copyWith({List<CoinModel>? coins, bool? isLoading}) {
    return BriefcaseState(
      coins: coins ?? this.coins,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [coins, isLoading];
}
