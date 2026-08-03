import 'package:crypto_assistant/widget/custom_text.dart';
import 'package:flutter/material.dart';

import '../../presentation/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:CustomNewText(text: "Crypto Assistant",color: AppColors.whiteColor,fontSize: 16,fontWeight: FontWeight.w600,),
      backgroundColor: AppColors.haiti,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
final List<Map<String, dynamic>> products = [
  {
    'id': 1,
    'name': 'iPhone 15',
    'price': 999,
    'category': {
      'id': 10,
      'name': 'Smartphones',
    },
    'manufacturer': {
      'id': 100,
      'name': 'Apple',
      'country': 'USA',
    },
  },
  {
    'id': 2,
    'name': 'Galaxy S24',
    'price': 899,
    'category': {
      'id': 10,
      'name': 'Smartphones',
    },
    'manufacturer': {
      'id': 101,
      'name': 'Samsung',
      'country': 'South Korea',
    },
  },
  {
    'id': 3,
    'name': 'MacBook Pro',
    'price': 2499,
    'category': {
      'id': 20,
      'name': 'Laptops',
    },
    'manufacturer': {
      'id': 100,
      'name': 'Apple',
      'country': 'USA',
    },
  },
];

 String c (List<Map<String,dynamic>>products){
   List<String> countries= [];
   String name = '';
  for (final product in products){
    final country = (product['manufacturer'] as Map<String, dynamic>)['country'] as String;
    if(country=='USA'){
      name = product['name']as String;
    }
    countries.add(country);
  }
return name;
}