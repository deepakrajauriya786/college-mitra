import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../const/color.dart';
import '../../../provider/bottom_navigation_provider.dart';

class BottomNavigationWidget extends StatelessWidget {
  const BottomNavigationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
        builder: (context, bottomnavigationprovider, child) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 70,
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                bottomnavigationprovider.setcurrentpos(0);
              },
              child: SizedBox(
                width: (screenwidth(context) - 20) / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/homes.png",
                      color: bottomnavigationprovider.getcurrentpos() == 0
                          ? themeColor
                          : Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "HOME",
                      style: TextStyle(
                          fontSize: 11,
                          color: bottomnavigationprovider.getcurrentpos() == 0
                              ? themeColor
                              : Colors.white,
                          fontFamily: 'bold'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bottomnavigationprovider.setcurrentpos(1);
              },
              child: SizedBox(
                width: (screenwidth(context) - 20) / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/computer.png",
                      color: bottomnavigationprovider.getcurrentpos() == 1
                          ? themeColor
                          : Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "BLOGS",
                      style: TextStyle(
                          fontSize: 11,
                          color: bottomnavigationprovider.getcurrentpos() == 1
                              ? themeColor
                              : Colors.white,
                          fontFamily: 'bold'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bottomnavigationprovider.setcurrentpos(2);
              },
              child: SizedBox(
                width: (screenwidth(context) - 20) / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/chat.png",
                      color: bottomnavigationprovider.getcurrentpos() == 2
                          ? themeColor
                          : Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "CHAT",
                      style: TextStyle(
                          fontSize: 11,
                          color: bottomnavigationprovider.getcurrentpos() == 2
                              ? themeColor
                              : Colors.white,
                          fontFamily: 'bold'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bottomnavigationprovider.setcurrentpos(3);
              },
              child: SizedBox(
                width: (screenwidth(context) - 20) / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/premiums.png",
                      color: bottomnavigationprovider.getcurrentpos() == 3
                          ? themeColor
                          : Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "PREMIUM",
                      style: TextStyle(
                          fontSize: 11,
                          color: bottomnavigationprovider.getcurrentpos() == 3
                              ? themeColor
                              : Colors.white,
                          fontFamily: 'bold'),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                bottomnavigationprovider.setcurrentpos(4);
              },
              child: SizedBox(
                width: (screenwidth(context) - 20) / 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/userss.png",
                      color: bottomnavigationprovider.getcurrentpos() == 4
                          ? themeColor
                          : Colors.white,
                      width: 20,
                      height: 20,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      "PROFILE",
                      style: TextStyle(
                          fontSize: 11,
                          color: bottomnavigationprovider.getcurrentpos() == 4
                              ? themeColor
                              : Colors.white,
                          fontFamily: 'bold'),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
