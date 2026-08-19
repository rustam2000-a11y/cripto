import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../home/home_widget/custom_app_bar.dart';
import '../presentation/app_colors.dart';
import '../presentation/app_images.dart';
import 'assistant_widgets/assistant_card_information.dart';
import 'assistant_widgets/filter_type.dart';
import 'filter_detailing_screen.dart';

class AssistantScreen extends StatelessWidget {
  const AssistantScreen({super.key});

  void _openDetails(
    BuildContext context,
    FilterType type,
    String description,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FilterDetailingScreen(
          type: type,
          description: description,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.haiti,
      appBar: CustomAppBar(text: "Аналитика", leadingIcon: false),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            spacing: 13,
            children: [

              Row(
                spacing: 12,
                children: [
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.siren,
                      text: 'Аномальное движение цены за за последние 24 часа',
                      description: 'Рост/подение  цены выше чем на 10%',
                      borderColor: AppColors.borderRed,
                      onTap: () => _openDetails(
                        context,
                        FilterType.abnormalMovement,
                        'Рост/подение  цены выше чем на 10%',
                      ),
                    ),
                  ),
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.barChart,
                      text: 'Движение цены за за последние 24 часа',
                      description: 'Рост/подение  цены выше чем на 5%',
                      borderColor: AppColors.borderOrange,
                      onTap: () => _openDetails(
                        context,
                        FilterType.priceMovement,
                        'Рост/подение  цены выше чем на 5%',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.inflationRate,
                      text: 'Большая волатильность',
                      description: 'Размах колебаний цены за 24 часа',
                      borderColor: AppColors.borderGreen,
                      onTap: () => _openDetails(
                        context,
                        FilterType.highVolatility,
                        'Размах колебаний цены за 24 часа',
                      ),
                    ),
                  ),
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.volatility,
                      text: 'Исторический максимум/минимум',
                      description:
                          'Приближается к своему историческому максимуму/минимуму',
                      borderColor: AppColors.borderTeal,
                      onTap: () => _openDetails(
                        context,
                        FilterType.historicalExtremum,
                        'Приближается к своему историческому максимуму/минимуму',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.inflation,
                      text: 'Оборачиваемость',
                      description: 'Аномально высокую активность торгов относительно размера монеты',
                      borderColor: AppColors.amber,
                      onTap: () => _openDetails(
                        context,
                        FilterType.turnover,
                        'Аномально высокую активность торгов относительно размера монеты',
                      ),
                    ),
                  ),
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.currency,
                      text: 'Приток капитала',
                      description:
                      'Рост/отток капитализации выше 5% за 24 часа',
                      borderColor: AppColors.magenta,
                      onTap: () => _openDetails(
                        context,
                        FilterType.capitalInflow,
                        'Рост/отток капитализации выше 5% за 24 часа',
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                spacing: 10,
                children: [
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.analyze,
                      text: 'У дневного пика/дна',
                      description: 'аномально высокую активность торгов относительно размера монеты',
                      borderColor: AppColors.borderGreen,
                      onTap: () => _openDetails(
                        context,
                        FilterType.dailyExtremum,
                        'аномально высокую активность торгов относительно размера монеты',
                      ),
                    ),
                  ),
                  Expanded(
                    child: AssistantCardInformation(
                      icon: AppImages.high,
                      text: 'Подтверждённая аномалия',
                      description:
                      'Цена сейчас находится у верхней или нижней границы дневного диапазона',
                      borderColor: AppColors.whiteColor,
                      onTap: () => _openDetails(
                        context,
                        FilterType.confirmedAnomaly,
                        'Цена сейчас находится у верхней или нижней границы дневного диапазона',
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}
