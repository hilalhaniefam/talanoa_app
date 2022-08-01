import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/admin/menu_button.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/listmenu_catalogue.dart';
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
      appBar: appBar(backButton: _handleBack),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor('A7B79F'),
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 35,
                  color: HexColor('#B9C5B2'),
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
                const SizedBox(
                  height: 54,
                ),
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: userMenuCategories1
                                .map((menu1) => buildMenuCategories(
                                    title: menu1['name'].toString(),
                                    onClicked: () => Navigator.pushNamed(
                                        context, menu1['to'].toString())))
                                .toList()),
                        Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: userMenuCategories2
                                .map((menu2) => buildMenuCategories(
                                    title: menu2['name'].toString(),
                                    onClicked: () => Navigator.pushNamed(
                                        context, menu2['to'].toString())))
                                .toList()),
                      ]),
                ]),
              ],
            ),
            Align(alignment: Alignment.bottomCenter, child: waves2()),
          ],
        ),
      ),
    );
  }
}
