import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:college_dost/provider/direct_admission_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DirectAdmissionScreen extends StatelessWidget {
  DirectAdmissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DirectAdmissionProvider>(
        builder: (context, provider, child) {
      return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "College Registration Started",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    height: screenheight(context) * 0.73,
                    child: PageView(
                      controller: provider.pageController,
                      onPageChanged: (int page) {
                        provider.currentPage = page;
                      },
                      children: provider.pages,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: SmoothPageIndicator(
                        controller: provider.pageController,
                        count: provider.pages.length,
                        effect: const WormEffect(
                          dotWidth: 16.0,
                          dotHeight: 2.0,
                          spacing: 8.0,
                          radius: 8.0,
                          dotColor: Colors.white,
                          activeDotColor: Colors.blue,
                          paintStyle: PaintingStyle.fill,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        provider.currentPage > 0
                            ? GestureDetector(
                                onTap: () =>
                                    provider.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: const Center(
                                    child: Text(
                                      "Prev",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            : const SizedBox.shrink(),
                        provider.currentPage < provider.pages.length - 1
                            ? GestureDetector(
                                onTap: () => provider.pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: themeColor,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 10),
                                  child: const Center(
                                      child: Text(
                                    'Next',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ));
    });
  }
}
