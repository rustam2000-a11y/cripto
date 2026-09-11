import 'package:equatable/equatable.dart';

abstract class InsightEffect extends Equatable {
  const InsightEffect();

  @override
  List<Object?> get props => [];
}

class InsightShowError extends InsightEffect {
  const InsightShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
