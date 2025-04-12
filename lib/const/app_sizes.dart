import 'package:flutter/cupertino.dart';

double screenwidth(context) {
  double width = MediaQuery.of(context).size.width;
  return width;
}

double screenheight(context) {
  double height = MediaQuery.of(context).size.height;
  return height;
}

class HeightGap extends StatelessWidget {
  const HeightGap({super.key, required this.gap});
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.sizeOf(context).height * gap);
  }
}

class WidthGap extends StatelessWidget {
  const WidthGap({super.key, required this.gap});
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: MediaQuery.sizeOf(context).width * gap);
  }
}
