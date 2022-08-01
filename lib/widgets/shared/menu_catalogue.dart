import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/waves.dart';

Widget buildListMenu({
  required String title,
  required Widget child,
  required BuildContext context,
}) =>
    Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 35,
          color: HexColor('#B9C5B2'),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: const TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 10),
            child: child,
          ),
        ),
        waves2(),
      ],
    );
