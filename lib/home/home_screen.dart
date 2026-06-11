import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:flutter/material.dart';

import '../widget/coin_card.dart';
import 'home_widget/custom_app_bar.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.haiti,
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CoinCard(),


          ],
        ),
      ),
    );
  }
}
