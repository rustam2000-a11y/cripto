import 'package:equatable/equatable.dart';

import '../data/models/language.dart';

class LanguageState extends Equatable {
  const LanguageState({this.selectedLanguage = Language.english});

  final Language selectedLanguage;

  LanguageState copyWith({Language? selectedLanguage}) {
    return LanguageState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
    );
  }

  @override
  List<Object?> get props => [selectedLanguage];
}
