// cover_image.dart

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  static const double coverHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: coverHeight,
      // child: Image.asset(
      //   'assets/images/shopcenter.png',
      //   fit: BoxFit.cover,
      // ),
      child: ImageSlideshow(
        indicatorColor: Colors.blue,
        onPageChanged: (value) {
          debugPrint('Page changed: $value');
        },
        autoPlayInterval: 5000,
        isLoop: true,
        children: [
          Image.asset(
            'assets/images/shopcenter.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/repairing.png',
            fit: BoxFit.cover,
          ),
          Image.asset(
            'assets/images/live_tracking3.gif',
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
