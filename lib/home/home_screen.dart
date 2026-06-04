import 'package:flutter/material.dart';

import 'home_widget/custom_app_bar.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
