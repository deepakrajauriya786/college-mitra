import 'package:action_slider/action_slider.dart';
import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/screens/premium/screens/premium_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:provider/provider.dart';

import '../../../provider/bottom_navigation_provider.dart';

class PremiumOnboardScreen extends StatefulWidget {
  PremiumOnboardScreen({super.key});

  @override
  State<PremiumOnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<PremiumOnboardScreen> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BottomNavigationProvider>(
          builder: (context, provider, child) {
        return Stack(children: [
          LiquidSwipe(
            pages: provider.pagesPremium,
            enableLoop: false,
            liquidController: provider.pageController,
            onPageChangeCallback: (val) {
              setState(() {
                currentPage = val;
              });
            },
            slideIconWidget: currentPage == provider.pages.length - 1
                ? const SizedBox()
                : const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
            enableSideReveal: true,
          ),
          (currentPage == provider.pages.length - 1)
              ? Positioned(
                  bottom: screenheight(context) * 0.15,
                  right: 30,
                  left: 30,
                  child: Center(
                      child: ActionSlider.standard(
                    width: 300,
                    height: 60,
                    toggleColor: Colors.blue,
                    foregroundBorderRadius: BorderRadius.circular(12),
                    backgroundBorderRadius: BorderRadius.circular(12),
                    backgroundColor: Colors.white,
                    actionThresholdType: ThresholdType.release,
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                    action: (controller) async {
                      controller.loading();
                      await Future.delayed(const Duration(seconds: 3));
                      controller.success();
                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PremiumPage(),
                          ));
                      controller.reset();
                    },
                    child: const Text(
                      'Unlock Premium',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  )),
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
          // Positioned(
          //   top: 40,
          //   right: 40,
          //   child: GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => SignupScreen(),
          //           ));
          //     },
          //     child: const Text(
          //       "Skip",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //         color: themegrey,
          //       ),
          //     ),
          //   ),
          // )
        ]);
      }),
    );
  }
}
