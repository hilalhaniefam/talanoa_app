import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/get_menu.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/menu_catalogue.dart';
import 'package:talanoa_app/widgets/shared/listmenu_catalogue.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class AdminDessert extends StatefulWidget {
  const AdminDessert({Key? key}) : super(key: key);

  @override
  State<AdminDessert> createState() => _MenudataState();
}

class _MenudataState extends State<AdminDessert> {
  Future<http.Response> getMenuByCategories() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    Response response = await http.get(Uri.parse('$ipurl/menu/get'),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body.toString());
    print(response.body);
    setState(() {
      listMenu = listMenuByType = data['payload'];
      listMenuByType = listMenu
          .where(((category) => category['type'] == 'Dessert'))
          .toList();
    });
    print('INI LISTMENU:');
    print(listMenu);
    print('INIIIIIIIIIIIIIIIIIIIIIIIIIII!!!!!!!:');
    print(listMenuByType);
    return response;
  }

  @override
  void initState() {
    super.initState();
    getMenuByCategories();
  }

  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(backButton: _handleBack),
        body: RefreshIndicator(
          onRefresh: getMenuByCategories,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: HexColor('A7B79F'),
              child: buildListMenu(
                  title: 'Dessert',
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: rowItemAdmin(
                      context: context,
                      list: listMenuByType,
                    ),
                  ),
                  context: context)),
        ));
  }
}
