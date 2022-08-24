import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

Widget listCardReserve({
  required name,
  required phone,
  required type,
  required time,
  required date,
  required pax,
}) =>
    Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(
          left: 36,
          top: 29,
          right: 78,
        ),
        color: HexColor('F1ECE1'),
        child: SizedBox(
            width: 267,
            height: 210,
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
                      type,
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
                      time,
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
                      date,
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
                      pax,
                      style: const TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () {/* ... */},
                    ),
                    IconButton(
                      icon: const Icon(Icons.cancel_outlined),
                      onPressed: () {/* ... */},
                    ),
                  ],
                ),
              ],
            )));