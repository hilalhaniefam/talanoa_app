import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> menuCategories1 = [
  {'name': 'Coffee', 'to': '/coffee'},
  {'name': 'Non Coffee', 'to': '/non-coffee'},
  {'name': 'Mocktail', 'to': '/mocktail'},
  {'name': 'Flavoured Tea', 'to': '/flavoured-tea'},
];
final List<Map<String, String>> menuCategories2 = [
  {'name': 'Main Course', 'to': '/main-course'},
  {'name': 'Toasted Bread', 'to': '/toasted-bread'},
  {'name': 'Dessert', 'to': '/dessert'},
  {'name': 'Snack', 'to': '/snack'},
];

List<Map<String, String>> categories1 = [
  {'name': 'CF', 'type': 'Coffee'},
  {'name': 'NCF', 'type': 'Non Coffee'},
  {'name': 'MT', 'type': 'Mocktail'},
  {'name': 'FT', 'type': 'Flavoured Tea'},
];
List<Map<String, String>> categories2 = [
  {'name': 'MC', 'type': 'Main Course'},
  {'name': 'TB', 'type': 'Toasted Bread'},
  {'name': 'DS', 'type': 'Dessert'},
  {'name': 'SK', 'type': 'Snack'},
];

// final List<String> chooseCategory1 = ['CF', 'NCF', 'MT', 'FT'];
// final List<String> chooseCategory2 = ['MC', 'RB', 'DS', 'SK'];



// final List<Widget> menu1 = menuCategories1
//     .map((menu1) => buildMenuCategories(title: menu1, onClicked: () {}))
//     .toList();

// final List<Widget> menu2 = menuCategories2
//     .map((menu2) => buildMenuCategories(title: menu2, onClicked: () {}))
//     .toList();

// final List<Widget> row1 = chooseCategory1
//     .map((category) => Row(
//           children: [
//             buildButtonChooseCategory(title: category, onClicked: () {})
//           ],
//         ))
//     .toList();

// final List<Widget> row2 = chooseCategory2
//     .map((category2) => Row(
//           children: [
//             buildButtonChooseCategory(title: category2, onClicked: () {})
//           ],
//         ))
//     .toList();
