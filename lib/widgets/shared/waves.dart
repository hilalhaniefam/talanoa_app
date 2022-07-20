import 'package:flutter/material.dart';

const String wavesImg = 'assets/images/Vector.png';

Container waves() {
  return Container(
    height: 90,
    decoration: const BoxDecoration(
      image: DecorationImage(fit: BoxFit.fill, image: AssetImage(wavesImg)),
    ),
  );
}
