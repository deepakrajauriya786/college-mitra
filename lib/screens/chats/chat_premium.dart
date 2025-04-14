import 'package:action_slider/action_slider.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';

import '../dashboard/chat_screen.dart';
import '../premium/screens/premium_details_screen.dart';

class ChatPremium extends StatelessWidget {
  const ChatPremium({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
        child: Column(
          children: [
            const SizedBox(height: 80),
            const Text(
              "Find Your Buddy",
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/images/chat_premium.png",
              height: 200,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            const Text(
              "Join the premium access to chat with verfied students , roomates and mentors",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            Spacer(),
            Center(
              child: ActionSlider.standard(
                width: 300,
                height: 60,
                toggleColor: Colors.blue,
                foregroundBorderRadius:
                    BorderRadius.circular(12), // Rounded corners
                backgroundBorderRadius: BorderRadius.circular(12),
                backgroundColor: Colors.white,
                actionThresholdType: ThresholdType.release,
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                action: (controller) async {
                  controller.loading();
                  await Future.delayed(const Duration(seconds: 1));
                  controller.success();
                  await Future.delayed(const Duration(seconds: 1));
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(),
                        // builder: (context) => PremiumPage(),
                      ));
                  controller.reset();
                },
                child: const Text(
                  'Unlock Chat',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              // ActionSlider.standard(
              //   backgroundColor: Colors.white,
              //   sliderBehavior: SliderBehavior.stretch,
              //   icon: const Icon(
              //     Icons.arrow_forward_ios,
              //     color: Colors.white,
              //     size: 18,
              //   ),
              //   child: const Text(
              //     'Unlock Premium',
              //     style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         fontSize: 18,
              //         color: themeColor),
              //   ),
              //   action: (controller) async {
              //     controller.loading();
              //     await Future.delayed(const Duration(seconds: 1));
              //     controller.success();
              //     await Future.delayed(const Duration(seconds: 1));
              //     Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => PremiumPage(),
              //         ));
              //     controller.reset();
              //   },
              // ),
            ),
            SizedBox(
              height: 70,
            )
          ],
        ),
      ),
    );
  }
}
