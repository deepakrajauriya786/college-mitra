import 'dart:async';

import 'package:college_dost/screens/onboard/onboard_screen.dart';
import 'package:flutter/material.dart';

import '../const/config.dart';
import '../const/navigator.dart';
import 'dashboard/bottom_bar.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {



  void userCheck() async {
    String userId = await UID;
    print(userId);
    if(userId.isNotEmpty){
      replaceScreen(context, BottomBar(),
          direction: SlideDirection.right);
    }else{
      replaceScreen(context, OnboardScreen(), direction: SlideDirection.right);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer(const Duration(seconds: 0), () {
      userCheck();
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Image.asset("assets/images/mainsplash.png"),
      ),
    );
  }
}
