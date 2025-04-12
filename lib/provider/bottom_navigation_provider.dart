import 'package:flutter/material.dart';
import 'package:liquid_swipe/PageHelpers/LiquidController.dart';

import '../const/color.dart';
import '../screens/onboard/widgets/page_screen.dart';

class BottomNavigationProvider with ChangeNotifier {
  int currentpos = 0;

  int get _currentpos => currentpos;

  void setcurrentpos(index) {
    currentpos = index;
    notifyListeners();
  }

  int getcurrentpos() {
    return _currentpos;
  }

  LiquidController pageController = LiquidController();
  final pages = [
    PageScreen(
      title: "24x7 Admission Support",
      desc:
          "Personalized guidance, calls, and meetings until you secure a seat by best option in a Top Engineering, Medical or Law college",
      uri: "assets/images/architecture.png",
      color: themeColor.withValues(alpha: 0.3),
    ),
    PageScreen(
      title: "Management Quota",
      desc:
          "Hassle-free Admission to Top Colleges even on your Low marks with Management Quota —your dream, our priority!",
      uri: "assets/images/school.png",
      color: themeRed.withValues(alpha: 0.3),
    ),
    PageScreen(
      title: "Public & Private Chat",
      desc:
          "Connect with future classmates in Public chats or get personalized advice in Private. Make friends before you even arrive!",
      uri: "assets/images/chating.png",
      color: Colors.orange.withValues(alpha: 0.3),
    ),
    PageScreen(
      title: "Find Accomodation",
      desc:
          "Find the perfect place to call Home near your campus. Browse verified listings and connect with roommates.",
      uri: "assets/images/graduation.png",
      color: Colors.blue.withValues(alpha: 0.3),
    ),
  ];

  final pagesPremium = [
    const PageScreen(
        title: "24x7 Admission Support",
        desc:
            "Personalized guidance, calls, and meetings until you secure a seat by best option in a Top Engineering, Medical or Law college",
        uri: "assets/images/architecture.png",
        color: Colors.black,
        titleColor: themeColor,
        descColor: Colors.white),
    const PageScreen(
        title: "Management Quota",
        desc:
            "Hassle-free Admission to Top Colleges even on your Low marks with Management Quota —your dream, our priority!",
        uri: "assets/images/school.png",
        color: Colors.black,
        titleColor: themeColor,
        descColor: Colors.white),
    PageScreen(
      title: "Public & Private Chat",
      desc:
          "Connect with future classmates in Public chats or get personalized advice in Private. Make friends before you even arrive!",
      uri: "assets/images/chating.png",
      color: Colors.black,
      titleColor: themeColor,
      descColor: Colors.white,
    ),
    PageScreen(
      title: "Find Accomodation",
      desc:
          "Find the perfect place to call Home near your campus. Browse verified listings and connect with roommates.",
      uri: "assets/images/graduation.png",
      titleColor: themeColor,
      descColor: Colors.white,
      color: Colors.black,
    ),
  ];
}
