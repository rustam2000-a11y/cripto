import 'package:equatable/equatable.dart';

abstract class CoinEffect extends Equatable {
  const CoinEffect();

  @override
  List<Object?> get props => [];
}

class CoinShowError extends CoinEffect {
  const CoinShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class CoinNavigateToLogin extends CoinEffect {
  const CoinNavigateToLogin();
}

class CoinNavigateToBriefcase extends CoinEffect {
  const CoinNavigateToBriefcase();
}
