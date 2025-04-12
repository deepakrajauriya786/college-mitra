import 'package:action_slider/action_slider.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import '../premium/screens/premium_details_screen.dart';

class PremiumScreen extends StatelessWidget {
  const PremiumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: darkgr,
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Text(
                  "Premium Guidance",
                  style: TextStyle(
                      color: Colors.white.withOpacity(1),
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/pre1.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/pre2.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/pre3.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset("assets/images/pre4.png"),
                ),
                const SizedBox(
                  height: 15,
                ),
                ActionSlider.standard(
                  backgroundColor: themelightblue,
                  sliderBehavior: SliderBehavior.stretch,
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 18,
                  ),
                  child: const Text(
                    'Slide to confirm',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
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
                ),
                const SizedBox(
                  height: 65,
                ),
              ],
            ),
          ),
        ));
  }
}
