import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class CoinSearchField extends StatelessWidget {
  const CoinSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: SizedBox(
        height: 40,
        child: TextField(
          onChanged: onChanged,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: const Color(0xFF8B5CF6),
          decoration: InputDecoration(
            hintText: S.of(context).search,
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 12),
              child: Icon(
                Icons.search_rounded,
                color: AppColors.textSecondary,
                size: 24,
              ),
            ),

            filled: true,
            fillColor: AppColors.deepIndigo,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.indigo),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.jacarta,
                width: 1.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
