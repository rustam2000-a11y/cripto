import 'package:flutter/material.dart';

enum AppPage {
  home(
    number: 0,
    label: 'Главная',
    icon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  assistant(
    number: 1,
    label: 'Сигналы',
    icon: Icons.smart_toy_outlined,
    activeIcon: Icons.smart_toy,
  );

  const AppPage({
    required this.number,
    required this.label,
    required this.icon,
    required this.activeIcon,
  });

  final int number;
  final String label;
  final IconData icon;
  final IconData activeIcon;

  static AppPage fromNumber(int number) {
    return AppPage.values.firstWhere((page) => page.number == number);
  }
}
