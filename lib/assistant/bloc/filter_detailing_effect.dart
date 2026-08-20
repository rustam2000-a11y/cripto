import 'package:equatable/equatable.dart';

abstract class FilterDetailingEffect extends Equatable {
  const FilterDetailingEffect();

  @override
  List<Object?> get props => [];
}

class FilterDetailingShowError extends FilterDetailingEffect {
  const FilterDetailingShowError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
