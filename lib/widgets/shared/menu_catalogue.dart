import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

final List<String> menuCategories1 = [
  'Coffee',
  'Non Coffee',
  'Mocktail',
  'Flavoured Tea'
];
final List<String> menuCategories2 = [
  'Main Course',
  'Roti Bakar',
  'Dessert',
  'Snack'
];

final List<String> chooseCategory1 = ['CF', 'NCF', 'MT', 'FT'];
final List<String> chooseCategory2 = ['MC', 'RB', 'DS', 'SK'];

final List<Widget> menu1 = menuCategories1
    .map((menu1) => Column(children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 134,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      menu1,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 25,
          )
        ]))
    .toList();

final List<Widget> menu2 = menuCategories2
    .map((menu1) => Column(children: [
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 134,
                height: 80,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      menu1,
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
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 25,
          )
        ]))
    .toList();

final List<Widget> row1 = chooseCategory1
    .map((category) => Row(
          children: [
            SizedBox(
                child: OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.black, width: 1.5)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),
              onPressed: () {},
              child: Text(
                category,
                style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 20,
                    color: Colors.black),
              ),
            )),
          ],
        ))
    .toList();

final List<Widget> row2 = chooseCategory2
    .map((category2) => Row(
          children: [
            SizedBox(
                child: OutlinedButton(
              style: ButtonStyle(
                side: MaterialStateProperty.all(
                    const BorderSide(color: Colors.black, width: 1.5)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0))),
              ),
              onPressed: () {},
              child: Text(
                category2,
                style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 20,
                    color: Colors.black),
              ),
            )),
          ],
        ))
    .toList();
