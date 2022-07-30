import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

AppBar appBar({required VoidCallback backButton}) => AppBar(
      toolbarHeight: 60,
      leading: IconButton(
        onPressed: backButton,
        icon: const Icon(Icons.arrow_back),
        color: Colors.black,
      ),
      elevation: 0,
      backgroundColor: HexColor('#B9C5B2'),
    );
