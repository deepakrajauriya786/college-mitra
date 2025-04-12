import 'package:college_dost/const/app_sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PageScreen extends StatelessWidget {
  final String uri;
  final String title;
  final Color color;
  final Color titleColor;
  final Color descColor;

  final String desc;

  const PageScreen(
      {super.key,
      required this.uri,
      this.color = Colors.black,
      required this.title,
      required this.desc,
      this.titleColor = Colors.black,
      this.descColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.white,
      height: screenheight(context),
      width: screenwidth(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: screenheight(context),
        width: screenwidth(context),
        color: color,
        child: Column(
          children: [
            const SizedBox(
              height: 110,
            ),
            Image.asset(
              uri,
              width: 250,
              fit: BoxFit.cover,
              height: 250,
            ),
            Text(
              title,
              style: TextStyle(
                  color: titleColor, fontWeight: FontWeight.bold, fontSize: 21),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 7,
            ),
            Text(
              desc,
              style: TextStyle(
                  color: descColor, fontWeight: FontWeight.w500, fontSize: 15),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
