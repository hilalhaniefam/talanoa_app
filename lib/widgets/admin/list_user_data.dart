import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget listCardUsers({required name, required phone, required email}) => Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.only(left: 36, right: 36, top: 15),
    color: HexColor('F1ECE1'),
    child: SizedBox(
      width: 261,
      height: 111,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 34, top: 22),
              child: Text(
                name,
                style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 34, top: 6),
              child: Text(
                phone,
                style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 34, top: 6),
              child: Text(
                email,
                style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    ));
