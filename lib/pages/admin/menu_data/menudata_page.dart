import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/menu_data/addmenu_page.dart';
import 'package:talanoa_app/widgets/admin/menu_button.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/listmenu_catalogue.dart';

class Menudata extends StatefulWidget {
  const Menudata({Key? key}) : super(key: key);

  @override
  State<Menudata> createState() => _MenudataState();
}

class _MenudataState extends State<Menudata> {
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAdmin(backButton: _handleBack, title: 'Menu Data'),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: HexColor('A7B79F'),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 45.0, vertical: 47),
                child: Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: menuCategories1
                              .map((menu1) => buildMenuCategories(
                                  title: menu1['name'].toString(),
                                  onClicked: () => Navigator.pushNamed(
                                      context, menu1['to'].toString())))
                              .toList(),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: menuCategories2
                              .map((menu2) => buildMenuCategories(
                                  title: menu2['name'].toString(),
                                  onClicked: () => Navigator.pushNamed(
                                      context, menu2['to'].toString())))
                              .toList(),
                        ),
                      ]),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const AddMenu()));
                        },
                        child: const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.add,
                              color: Colors.black,
                              size: 35,
                            )),
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(55, 55),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: HexColor('#F1ECE1'),
                            shadowColor: Colors.black)),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
