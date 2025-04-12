import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../provider/onboard_provider.dart';
import 'on_board_page.dart';

class AccomodationSlide extends StatelessWidget {
  const AccomodationSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: screenwidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Selector<OnBoardProvider, PageController>(
                      selector: (_, provider) => provider.onbordingScroll,
                      builder: (_, controller, __) {
                        return SmoothPageIndicator(
                          controller: controller,
                          count: context
                              .read<OnBoardProvider>()
                              .onBoarddata
                              .length,
                          axisDirection: Axis.horizontal,
                          effect: const ExpandingDotsEffect(
                            activeDotColor: themeColor,
                            dotHeight: 8,
                            dotWidth: 10,
                          ),
                        );
                      },
                    ),

                    // Image.asset(
                    //   "assets/images/vector.jpg",
                    //   height: 190,
                    //   width: screen.width,
                    //   fit: BoxFit.cover,
                    // ),
                  ],
                ),
                const SizedBox(height: 240),
              ],
            ),
          ),

          // PageView Builder - Rebuilds only when page changes
          Selector<OnBoardProvider, PageController>(
            selector: (_, provider) => provider.onbordingScroll,
            builder: (_, controller, __) {
              return PageView.builder(
                controller: controller,
                onPageChanged: (value) {
                  context.read<OnBoardProvider>().setcurrentstate(value);
                },
                itemCount: context.read<OnBoardProvider>().onBoarddata.length,
                itemBuilder: (context, index) {
                  return OnBoardPage(
                    index: index,
                    screen: screen,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
