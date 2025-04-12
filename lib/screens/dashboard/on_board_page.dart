import 'package:action_slider/action_slider.dart';
import 'package:college_dost/const/color.dart';
import 'package:college_dost/screens/dashboard/payment_gateway.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/onboard_provider.dart';
import '../premium/screens/premium_details_screen.dart';

class OnBoardPage extends StatelessWidget {
  final int index;
  final Size screen;

  const OnBoardPage({
    super.key,
    required this.index,
    required this.screen,
  });

  @override
  Widget build(BuildContext context) {
    final provider = context.read<OnBoardProvider>();
    final currentStep = context.watch<OnBoardProvider>().currentstep;

    return Container(
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 80),
          Text(
            provider.onBoarddata[index]["title"]!,
            style: TextStyle(
              color: themeColor,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 10),
          Image.asset(
            provider.onBoarddata[index]["image"]!,
            width: screen.width - 40,
            height: 330,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          Text(
            provider.onBoarddata[index]["desc"]!,
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 130),
          Align(
            alignment: currentStep == 2
                ? Alignment.bottomCenter
                : Alignment.bottomRight,
            child: currentStep == 2
                ? Center(
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentGateway(id: '2'),
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
                  )
                : GestureDetector(
                    onTap: () {
                      final currentPage =
                          provider.onbordingScroll.page?.round() ?? 0;
                      if (currentPage < provider.onBoarddata.length - 1) {
                        provider.onbordingScroll.animateToPage(
                          currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                        provider.setcurrentstate(currentPage + 1);
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.black,
                      ),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
