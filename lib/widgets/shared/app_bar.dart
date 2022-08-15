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

PreferredSize appBarAdmin(
        {required VoidCallback backButton, required String title}) =>
    PreferredSize(
      preferredSize: const Size.fromHeight(100.0),
      child: AppBar(
        leading: IconButton(
          onPressed: backButton,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                title,
                style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(5, 5),
                          blurRadius: 15),
                    ],
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                    color: Colors.black),
              ),
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
    );
