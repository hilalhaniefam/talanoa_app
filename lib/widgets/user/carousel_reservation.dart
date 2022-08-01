import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

int activeIndex = 0;
Widget buildImage(String imgList, int index) => Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(image: AssetImage(imgList), fit: BoxFit.cover),
      ),
    );

Widget buildIndicator(imgListAssets) => AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: imgListAssets.length,
      effect: const JumpingDotEffect(dotWidth: 10, dotHeight: 10),
    );
