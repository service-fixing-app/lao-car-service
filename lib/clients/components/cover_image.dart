// cover_image.dart

import 'package:flutter/material.dart';

class CoverImage extends StatelessWidget {
  const CoverImage({Key? key}) : super(key: key);

  static const double coverHeight = 240.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: coverHeight,
      child: Image.asset(
        'assets/images/service-car.jpg',
        fit: BoxFit.cover,
      ),
    );
  }
}
