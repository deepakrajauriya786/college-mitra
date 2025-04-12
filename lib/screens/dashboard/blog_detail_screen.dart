import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/color.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatelessWidget {
  const BlogDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: screenwidth(context),
            height: screenheight(context) * 0.35,
            child: Image.asset(
              "assets/images/images.jpeg",
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 40,
            left: 15,
            right: 15,
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ))
              ],
            ),
          ),
          Container(
            height: screenheight(context),
            width: screenwidth(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Container(
                  height: screenheight(context) * 0.70,
                  width: screenwidth(context),
                  decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16))),
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          const Text(
                            "POPULAR",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: themeColor, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Application Open For JMI Delhi BTech",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    color: Colors.grey[850],
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              const Text(
                                "CollegeFriend",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                              "The university Jamia Millia Islamia (JMI) provides a range of undergraduate and graduate programs. Online applications are now available for all courses at Jamia Millia Islamia (JMI), with the exception of the PhD program, for the 2024-2025 academic year.\n\n• Application Form Starts - 20 Feb 2024\n\n• Application End Date - 30 March \n\n• Official Website - https:/drntruhs.in/jmi-application-form \n\n• Application Fee For BTech - 500\n\n\nIn order to avoid any inconvenience, candidates are urged to fill out the form as soon as possible or before the deadline. We have included all of the details you need to fill out the Jamia Application Form 2024 in this post, including registration details, fees, modes, dates, and eligibility requirements.\n\nCandidates should read the following section to learn all of the requirements for Jamia Eligibility for 2024.• A minimum of 50% must have been achieved on the Class 12 or equivalent test  for candidates to be considered for UG programs.\n\nB.Tech. admission is based on JEE Main 2024 final ranks, B.Arch. admission on NATA-2024 final ranks by Council of Architecture 2024, and BDS admission is based on NEET-2024 by Medical Counselling Cell (MCC) of D.G.H.S. Gol. Any vacancies transferred by MCC will be published on the university's website.",
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500)),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
