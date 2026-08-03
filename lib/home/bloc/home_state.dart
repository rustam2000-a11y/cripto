import 'package:equatable/equatable.dart';

import '../data/models/coin_model.dart';



class HomeState extends Equatable {
  const HomeState({
    this.items = const [],
    this.isLoading = false,
    this.searchQuery = '',
  });

  final List<CoinModel> items;
  final bool isLoading;
  final String searchQuery;

  HomeState copyWith({
    List<CoinModel>? items,
    bool? isLoading,
    String? searchQuery,
  }) {
    return HomeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [items, isLoading, searchQuery];
}
