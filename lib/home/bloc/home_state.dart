import 'package:equatable/equatable.dart';

import '../data/models/coin_model.dart';



class HomeState extends Equatable {
  const HomeState({
    this.items = const [],
    this.isLoading = false,
  });

  final List<CoinModel> items;
  final bool isLoading;

  HomeState copyWith({
    List<CoinModel>? items,
    bool? isLoading,
  }) {
    return HomeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [items, isLoading];
}
