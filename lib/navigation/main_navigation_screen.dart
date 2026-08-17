import 'package:flutter/material.dart';

import '../assistant/assistant_screen.dart';
import '../home/home_screen.dart';
import 'app_page.dart';
import 'custom_bottom_nav_bar.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  AppPage _currentPage = AppPage.home;

  static const _screens = {
    AppPage.home: HomeScreen(),
    AppPage.assistant: AssistantScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentPage.number,
            children: AppPage.values.map((page) => _screens[page]!).toList(),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Center(
                  child: CustomBottomNavBar(
                    currentPage: _currentPage,
                    onPageSelected: (page) {
                      setState(() => _currentPage = page);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
