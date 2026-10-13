import 'package:flutter/material.dart';
import '../widgets/navigation/bottom_nav_bar.dart';
import 'care_guides_screen.dart';
import 'cart_screen.dart';
import 'home_screen.dart';
import 'shop_screen.dart';
import 'wishlist_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  void _onTabChange(int index) {
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      HomeScreen(onTabChange: _onTabChange),
      const ShopScreen(),
      const CareGuidesScreen(),
      WishlistScreen(onExploreTap: () => _onTabChange(1)),
      CartScreen(onExploreTap: () => _onTabChange(1)),
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Current Active Screen
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),

          // Floating Glassmorphic Bottom Navigation Bar
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabChange,
            ),
          ),
        ],
      ),
    );
  }
}
