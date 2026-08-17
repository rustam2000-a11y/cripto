import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class AssistantCardInformation extends StatelessWidget {
  const AssistantCardInformation({
    super.key,
    required this.icon,
    required this.text,
    required this.description,
    required this.borderColor,
  });

  final String icon;
  final String text;
  final String description;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(

      constraints: BoxConstraints(
        maxHeight: 220,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
        color: AppColors.portGore,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: borderColor.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(20)
            ),
            padding: EdgeInsets.all(10),
            child: Image.asset(icon, width: 30, height: 30),
          ),
          SizedBox(height: 20,),
          CustomNewText( text: text,fontSize: 15,textAlign: TextAlign.start,),
          Spacer(),
          CustomNewText( text: description,color: AppColors.blueBell,textAlign: TextAlign.start,),
        ],
      ),
    );
  }
}
