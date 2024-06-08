// cover_image.dart

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class CoverImageTowingShop extends StatelessWidget {
  const CoverImageTowingShop({Key? key}) : super(key: key);

  static const double coverHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: coverHeight,
      child: ImageSlideshow(
        indicatorColor: Colors.blue,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval: 5000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/towingtruck.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/towing-truck1.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/towing-truck3.jpg',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/towing-truck2.gif',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
