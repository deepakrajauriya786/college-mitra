import 'package:carousel_slider/carousel_slider.dart';
import 'package:college_dost/const/config.dart';
import 'package:flutter/cupertino.dart';

class CrauserSlider extends StatelessWidget {
  final bool autoplay;

  final double height, viewport;
   List<dynamic> datalist;
  CrauserSlider(
      {super.key,
      this.autoplay = true,
      required this.datalist,
      this.height = 170,
      this.viewport = 0.70});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: datalist.map((imagePath) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Image.network(BANNERIMAGE+
            imagePath,
            fit: BoxFit.contain,
          ),
        );
      }).toList(),
      options: CarouselOptions(
        height: height,
        aspectRatio: 14 / 9,
        viewportFraction: viewport,
        enableInfiniteScroll: true,
        autoPlay: autoplay,
        autoPlayInterval: const Duration(seconds: 3),
        enlargeCenterPage: true,
      ),
    );
  }
}
