import 'package:action_slider/action_slider.dart';
import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/navigator.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';
import 'direct_admission_screen.dart';
import 'education_load_screen.dart';

class EducationLoanSlide extends StatelessWidget {
  const EducationLoanSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            const Text(
              "Education Loan",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/education.png",
              width: screenwidth(context) - 40,
              height: 330,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              "Fast, Secure, and Flexible Loans for Indian and Abroad Education. Apply in Minutes. Get approved Faster.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 100),
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
                  Navigator.pop(context);
                  changeScreen(context, SmartEducationLoan());
                  controller.reset();
                },
                child: const Text(
                  'Apply Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
              //
              //   ActionSlider.standard(
              //     backgroundColor: Colors.white,
              //     sliderBehavior: SliderBehavior.stretch,
              //     icon: const Icon(
              //       Icons.arrow_forward_ios,
              //       color: Colors.white,
              //       size: 18,
              //     ),
              //     child: const Text(
              //       'Unlock Premium',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 18,
              //           color: themeColor),
              //     ),
              //     action: (controller) async {
              //       controller.loading();
              //       await Future.delayed(const Duration(seconds: 1));
              //       controller.success();
              //       await Future.delayed(const Duration(seconds: 1));
              //       Navigator.pop(context);
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => PremiumPage(),
              //           ));
              //       controller.reset();
              //     },
              //   ),
              // )
            ),
          ],
        ),
      ),
    );
  }
}
