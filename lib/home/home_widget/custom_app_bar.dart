import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../presentation/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.text,
    this.colors = AppColors.haiti,
    this.leadingIcon = true,
    this.action,
    
  });

  final String text;
  final Color colors;
  final bool leadingIcon;
  final Widget? action;
  

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: CustomNewText(
        text: text,
        color: AppColors.whiteColor,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      backgroundColor: colors,
      surfaceTintColor: Colors.transparent,
      scrolledUnderElevation: 0,
      leading: leadingIcon? IconButton(
        onPressed: Navigator.of(context).pop,
        icon: Icon(Icons.arrow_back_ios_new),
        color: Colors.white,
      )
      :SizedBox(),
      actions: [
        if (action != null) Padding(
          padding: const EdgeInsets.only(right: 18),
          child: action!,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


