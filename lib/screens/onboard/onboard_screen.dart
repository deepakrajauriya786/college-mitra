import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';

import '../../provider/bottom_navigation_provider.dart';
import '../auth/signup_screen.dart';

class OnboardScreen extends StatefulWidget {
  OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
          builder: (context, provider, child) {
        return Stack(children: [
          LiquidSwipe(
            pages: provider.pages,
            enableLoop: false,
            liquidController: provider.pageController,
            onPageChangeCallback: (val) {
              setState(() {
                currentPage = val;
              });
            },
            slideIconWidget: currentPage == provider.pages.length - 1
                ? const SizedBox()
                : const Icon(Icons.arrow_back_ios_new),
            enableSideReveal: true,
          ),
          (currentPage == provider.pages.length - 1)
              ? Positioned(
                  bottom: screenheight(context) * 0.15,
                  right: 0,
                  left: 0,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignupScreen(),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 70),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Center(
                        child: Text(
                          "Let's Get Started",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: screenheight(context) * 0.15,
                  left: screenwidth(context) * 0.36,
                  right: screenwidth(context) * 0.36,
                  child: GestureDetector(
                    onTap: () {
                      provider.pageController
                          .animateToPage(page: currentPage + 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(150)),
                      child: Image.asset(
                        "assets/images/forward.png",
                        width: 70,
                        fit: BoxFit.contain,
                        height: 70,
                      ),
                    ),
                  ),
                ),
          Positioned(
            top: 40,
            right: 40,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignupScreen(),
                    ));
              },
              child: const Text(
                "Skip",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: themegrey,
                ),
              ),
            ),
          )
        ]);
      }),
    );
  }
}
