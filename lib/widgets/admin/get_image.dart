import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class ImgPicker {
  static Widget inputImage({required VoidCallback onTap, required child}) =>
      Container(
        width: 69,
        height: 68,
        margin: EdgeInsets.only(right: 258, bottom: 25),
        child: DottedBorder(
            color: Colors.black,
            radius: const Radius.circular(8),
            strokeWidth: 1,
            child: GestureDetector(
              onTap: onTap,
              child: child,
            )),
      );
}
