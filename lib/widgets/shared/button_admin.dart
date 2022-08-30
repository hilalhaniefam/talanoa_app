import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget buttonAdmin(
        {required String title,
        required page,
        required BuildContext context}) =>
    Align(
        alignment: Alignment.center,
        child: SizedBox(
          width: 220,
          height: 115,
          child: ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => page));
              },
              child: Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: ElevatedButton.styleFrom(
                  primary: HexColor('#F1ECE1'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadowColor: Colors.black)),
        ));
