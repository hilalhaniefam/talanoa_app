import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget buildButtonChooseCategory(
        {required String title,
        required VoidCallback onClicked,
        required Color backgroundColor}) =>
    SizedBox(
      child: OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(backgroundColor),
          side: MaterialStateProperty.all(
              const BorderSide(color: Colors.black, width: 1.5)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0))),
        ),
        onPressed: onClicked,
        child: Text(title,
            style: const TextStyle(
                fontFamily: 'Josefin Sans', fontSize: 20, color: Colors.black)),
      ),
    );

Widget buildMenuCategories({
  required String title,
  required VoidCallback onClicked,
}) =>
    Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 134,
              height: 80,
              child: ElevatedButton(
                  onPressed: onClicked,
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 21,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      primary: HexColor('#F1ECE1'),
                      shadowColor: Colors.black)),
            )),
        const SizedBox(
          height: 25,
        )
      ],
    );
