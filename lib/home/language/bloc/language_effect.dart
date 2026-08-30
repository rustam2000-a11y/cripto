import 'package:equatable/equatable.dart';

abstract class LanguageEffect extends Equatable {
  const LanguageEffect();

  @override
  List<Object?> get props => [];
}

class LanguageApplied extends LanguageEffect {
  const LanguageApplied();
}
