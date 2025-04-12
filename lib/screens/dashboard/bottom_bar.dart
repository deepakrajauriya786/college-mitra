import 'package:college_dost/screens/dashboard/blog_screen.dart';
import 'package:college_dost/screens/dashboard/home_screen.dart';
import 'package:college_dost/screens/dashboard/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:provider/provider.dart';

import '../../provider/bottom_navigation_provider.dart';
import '../chats/chat_premium.dart';
import '../onboard/widgets/bottom_navigation_widget.dart';
import '../premium/screens/premium_onboard_screen.dart';

class BottomBar extends StatelessWidget {
  BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Consumer<BottomNavigationProvider>(
          builder: (context, bottomnavigationprovider, child) {
        if (bottomnavigationprovider.currentpos == 0) {
          return HomeScreen();
        } else if (bottomnavigationprovider.currentpos == 1) {
          return BlogScreen();
        } else if (bottomnavigationprovider.currentpos == 2) {
          return ChatPremium();
        } else if (bottomnavigationprovider.currentpos == 3) {
          return PremiumOnboardScreen();
        } else {
          return ProfileScreen();
        }
      }),
    
      bottomNavigationBar: const BottomNavigationWidget(),
    );
  }
}
