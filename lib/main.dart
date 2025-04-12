import 'package:college_dost/provider/bottom_navigation_provider.dart';
import 'package:college_dost/provider/direct_admission_provider.dart';
import 'package:college_dost/provider/management_quota_provider.dart';
import 'package:college_dost/provider/onboard_provider.dart';
import 'package:college_dost/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'const/color.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BottomNavigationProvider()),
      ChangeNotifierProvider(create: (_) => OnBoardProvider()),
      ChangeNotifierProvider(create: (_) => ManagementQuotaProvider()),
      ChangeNotifierProvider(create: (_) => DirectAdmissionProvider())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// new
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      title: 'College Friend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: themeColor),
        useMaterial3: true,
      ),
      home: Splash(),
    );
  }
}
