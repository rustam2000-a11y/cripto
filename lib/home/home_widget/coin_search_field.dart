import 'package:crypto_assistant/presentation/app_colors.dart';
import 'package:flutter/material.dart';

class CoinSearchField extends StatelessWidget {
  const CoinSearchField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
      child: SizedBox(
        height: 52,
        child: TextField(
          onChanged: onChanged,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: const Color(0xFF8B5CF6),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: const TextStyle(
              color: Color(0xFF8E8CB0),
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 16, right: 12),
              child: Icon(
                Icons.search_rounded,
                color: Color(0xFFC4C4D8),
                size: 24,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minWidth: 52,
              minHeight: 52,
            ),
            suffixIcon: const Icon(
              Icons.tune_rounded,
              color: Color(0xFFC4C4D8),
              size: 22,
            ),
            filled: true,
            fillColor: const Color(0xFF17143B),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(
                color: Color(0xFF34306E),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(26),
              borderSide: const BorderSide(
                color: AppColors.jacarta,
                width: 1.2,
              ),
            ),
          ),
        ),
      )
    );
  }
}
