import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget submitButton({required Function onTap, required String title}) =>
    SizedBox(
      width: 150,
      height: 40,
      child: FormHelper.submitButton(
        title,
        onTap,
        btnColor: HexColor("#F1ECE1"),
        borderColor: Colors.grey,
        txtColor: Colors.black,
        borderRadius: 10,
        fontSize: 20,
      ),
    );
