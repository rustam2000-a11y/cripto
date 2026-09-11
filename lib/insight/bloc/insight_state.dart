import 'package:equatable/equatable.dart';

import '../data/models/coin_insight.dart';

class InsightState extends Equatable {
  const InsightState({
    this.insights = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  final List<CoinInsight> insights;
  final bool isLoading;
  final String? errorMessage;

  InsightState copyWith({
    List<CoinInsight>? insights,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return InsightState(
      insights: insights ?? this.insights,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [insights, isLoading, errorMessage];
}
