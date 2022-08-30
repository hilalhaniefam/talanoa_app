import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Container linearGradient(
        {required BuildContext context, required Widget child}) =>
    Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('#F1ECE1'),
                HexColor("#A7B79F"),
              ]),
        ),
        child: child);
