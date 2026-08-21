import 'package:crypto_assistant/registration/registration_widget/login_title.dart';
import 'package:flutter/material.dart';

import '../home/home_widget/custom_app_bar.dart';
import '../presentation/app_colors.dart';
import '../presentation/app_images.dart';
import '../widget/custom_button.dart';
import '../widget/custom_divider.dart';
import '../widget/custom_text.dart';
import '../widget/custom_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: ''),
      backgroundColor: AppColors.haiti,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LoginTitle(
                    firstText: 'Создать акккаунт',
                    secondaryText: 'Это займет меньше минуты',
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    label: 'Name',
                    onChanged: (String value) {},
                    hintText: 'Name',
                    leftIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    label: 'Email',
                    onChanged: (String value) {},
                    hintText: 'Email',
                    leftIcon: Icons.email_outlined,
                  ),
                  SizedBox(height: 15),
                  CustomPasswordTextField(
                    label: 'Password',
                    onChanged: (String value) {},
                  ),
                  SizedBox(height: 30),
                  CustomButton(onTap: () {}, name: 'Войти'),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomNewText(
                        text: 'Забыл пароль?',
                        color: AppColors.activeBorder,
                        fontSize: 16,
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  CustomDivider(),
                  SizedBox(height: 30),
                  Row(
                    spacing: 12,
                    children: [
                      Expanded(
                        child: CustomButton(
                          onTap: () {},
                          name: 'Google',
                          icon: AppImages.google,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          onTap: () {},
                          name: 'Apple',
                          icon: AppImages.apple,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5,
                children: [
                  CustomNewText(text: 'Уже есть аккаунт?', fontSize: 18),
                  InkWell(
                    onTap: (){Navigator.pop(context);},
                    child: CustomNewText(
                      text: 'Войти',
                      fontSize: 18,
                      color: AppColors.activeBorder,
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
