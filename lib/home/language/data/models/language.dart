import 'package:flutter/widgets.dart';

enum Language {
  english(code: 'en', label: 'English'),
  russian(code: 'ru', label: 'Русский');

  const Language({required this.code, required this.label});

  final String code;
  final String label;

  Locale get locale => Locale(code);

  static Language fromCode(String code) {
    return Language.values.firstWhere(
      (language) => language.code == code,
      orElse: () => Language.english,
    );
  }
}
