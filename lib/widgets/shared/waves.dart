import 'package:flutter/material.dart';

const String wavesImg = 'assets/images/Vector.png';
const String wavesImg2 = 'assets/images/Vector2.png';

Container waves() {
  return Container(
    height: 69,
    decoration: const BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(wavesImg),
          alignment: Alignment.bottomCenter),
    ),
  );
}

Container waves2() {
  return Container(
    height: 69,
    decoration: const BoxDecoration(
      image: DecorationImage(fit: BoxFit.fill, image: AssetImage(wavesImg2)),
    ),
  );
}
