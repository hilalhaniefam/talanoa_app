import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

Future<void> deleteMenu(String menuId, BuildContext context) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  var userData = jsonDecode(sharedPreferences.getString('userData').toString());
  String token = userData['accessToken'];
  http.Response delResponse = await http.delete(Uri.parse('$ipurl/menu/delete'),
      headers: {'Authorization': 'Bearer $token'}, body: {'menuId': menuId});
  var data = jsonDecode(delResponse.body.toString());
  if (delResponse.statusCode == 200) {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('newListMenu', jsonEncode(data['payload']));
    ScaffoldMessenger.of(context)
        .showSnackBar(CustomSnackbar('Menu deleted succesfully'));
  }
}

Widget rowItemAdmin({
  required BuildContext context,
  required List list,
}) {
  return ListView(
    children: list.map((data) {
      var imageFile = data['imageUrl'];
      return Dismissible(
        background: deleteItem(),
        key: Key(data['menuId']),
        onDismissed: (direction) {
          deleteMenu(data['menuId'], context);
        },
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 115,
          child: Card(
            color: HexColor('A7B79F'),
            child: Row(
              children: [
                imageFile == null
                    ? Container(
                        color: HexColor('A7B79F'),
                        width: 60,
                        height: 61,
                        child: const Text('Image Not Found'),
                      )
                    : Image.network(
                        imageFile,
                        width: 130,
                      ),
                Container(
                  margin: const EdgeInsets.only(left: 17),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  width: 200,
                  height: 115,
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            data['name'],
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w400),
                          )),
                      const SizedBox(height: 6),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data['description'],
                          style: const TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget rowItemUser({
  required BuildContext context,
  required List list,
}) {
  return ListView(
    children: list.map((data) {
      var imageFile = data['imageUrl'];
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 115,
        child: Card(
          elevation: 0,
          color: HexColor('A7B79F'),
          child: Row(
            children: [
              imageFile == null
                  ? Container(
                      color: HexColor('A7B79F'),
                      width: 180,
                      height: 61,
                    )
                  : Image.network(
                      imageFile,
                    ),
              Container(
                margin: const EdgeInsets.only(left: 17),
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 2,
                ),
                width: 200,
                height: 115,
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          data['name'],
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w400),
                        )),
                    const SizedBox(height: 6),
                    Text(
                      data['description'],
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget deleteItem() => Container(
      color: Colors.redAccent,
      child: const Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(Icons.delete),
        ),
      ),
    );
