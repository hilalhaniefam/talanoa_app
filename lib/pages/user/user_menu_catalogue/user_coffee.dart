import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/menu_catalogue.dart';

class Coffee extends StatefulWidget {
  const Coffee({Key? key}) : super(key: key);

  @override
  State<Coffee> createState() => _MenudataState();
}

class _MenudataState extends State<Coffee> {
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(backButton: _handleBack),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: HexColor('A7B79F'),
            child: buildListMenu(
                title: 'Coffee', child: ListView(), context: context)));
  }
}
