import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/menu_catalogue.dart';
import 'package:talanoa_app/widgets/shared/waves.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  State<MenuPage> createState() => _MenudataState();
}

class _MenudataState extends State<MenuPage> {
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
      backgroundColor: HexColor('A7B79F'),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: HexColor('#B9C5B2')),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Menu',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 54, left: 46, right: 45),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: menu1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: menu2,
                ),
              ]),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 117),
            child: waves2(),
          )
        ],
      ),
    );
  }
}
