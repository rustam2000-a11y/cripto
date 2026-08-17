import '../presentation/app_images.dart';

enum AppPage {
  home(number: 0, label: 'Главная', icon: AppImages.home),
  assistant(number: 1, label: 'Сигналы', icon: AppImages.dataAnalytics);

  const AppPage({required this.number, required this.label, required this.icon});

  final int number;
  final String label;
  final String icon;

  static AppPage fromNumber(int number) {
    return AppPage.values.firstWhere((page) => page.number == number);
  }
}
