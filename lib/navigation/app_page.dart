import '../presentation/app_images.dart';

enum AppPage {
  home( icon: AppImages.home),
  assistant(icon: AppImages.dataAnalytics),
  briefcase( icon: AppImages.briefcase);

  const AppPage({ required this.icon});


  final String icon;


}
