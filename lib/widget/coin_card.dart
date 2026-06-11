import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

class CoinCard extends StatelessWidget {
  const CoinCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.containerColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.jacarta),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 4,
                    children: [
                      CustomNewText(
                        text: 'Bitcoin',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.titanWhite,
                      ),
                      CustomNewText(
                        text: 'ETH - #2',
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.victoria,
                      ),
                    ],
                  ),
                ],
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 4,
                children: [
                  CustomNewText(
                    text: '188.50',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.titanWhite,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8,vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green), // цвет не актуальный
                      color: Colors.teal,
                    ),
                    child: CustomNewText(
                      text: '2.4%',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: AppColors.victoria,
                    ),
                  ),
                ],
              ),
            ],
          ),// конец верхней Row
          SizedBox(height: 16,),
          Row(children: [
            Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  CustomNewText(text: 'Капитализация',fontSize: 11, color: AppColors.victoria,),
                  CustomNewText(text: '89B',fontSize: 13, color: AppColors.blueBell,fontWeight: FontWeight.w500,),
                ],
              ),
            ],)
          ],),

        ],
      ),
    );
  }
}
