import 'package:college_dost/const/app_sizes.dart';
import 'package:college_dost/const/navigator.dart';
import 'package:college_dost/screens/dashboard/managements_quota.dart';
import 'package:flutter/material.dart';

import '../../const/color.dart';

class ManagementQuotaSlide extends StatelessWidget {
  const ManagementQuotaSlide({super.key});

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
            Text(
              "Top Colleges -Limited Seats",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: themeColor,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              "assets/images/quata.jpg",
              width: screenwidth(context),
              height: 330,
              fit: BoxFit.fill,
            ),
            const SizedBox(height: 20),
            const Text(
              "Apply Now Through Management Quota - Fast, Easy, and 100% Trusted by lakhs of Students",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 100),
            GestureDetector(
              onTap: () {
                replaceScreen(context, ManagementsQuota());
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                margin: EdgeInsets.symmetric(horizontal: 7),
                decoration: BoxDecoration(
                    color: themeColor, borderRadius: BorderRadius.circular(12)),
                child: const Center(
                  child: Text(
                    "Apply Now",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
