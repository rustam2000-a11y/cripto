import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../home/home_widget/custom_app_bar.dart';
import '../presentation/app_colors.dart';
import 'assistant_widgets/filter_type.dart';

class FilterDetailingScreen extends StatelessWidget {
  const FilterDetailingScreen({
    super.key,
    required this.type,
    required this.description,
  });

  final FilterType type;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: AppColors.haiti,
      appBar: CustomAppBar(text: 'Детализация',),
      body: Column(
        children: [
          CustomNewText(text: description),
        ],
      ),
    );
  }
}
