import '../presentation/app_images.dart';

enum AppPage {
  home( icon: AppImages.home),
  assistant(icon: AppImages.dataAnalytics),
  insight(icon: AppImages.aiInsights),
  briefcase( icon: AppImages.briefcase);

  const AppPage({ required this.icon});


  final String icon;


}
