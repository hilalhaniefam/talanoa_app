import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class Userdata extends StatefulWidget {
  const Userdata({Key? key}) : super(key: key);
  @override
  State<Userdata> createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  _handleBack() => Navigator.of(context).pop();

  List<dynamic> users = [];

  Future<http.Response> fetchUsers() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    Response response = await http.get(Uri.parse('$ipurl/users'),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body.toString());
    print(response.body);
    setState(() {
      users = data['payload'];
    });
    print(users);
    return response;
  }

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Title(
            color: Colors.black,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 75, top: 55),
                child: Text(
                  'User Data',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(5, 5),
                            blurRadius: 15),
                      ],
                      fontFamily: 'Josefins Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 28,
                      color: Colors.black),
                ),
              ),
            )),
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
      backgroundColor: HexColor('A7B79F'),
      body: ListView(
        padding: const EdgeInsets.only(bottom: 29),
        children: users.map((data) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(left: 36, top: 29, right: 78),
              color: HexColor('F1ECE1'),
              child: SizedBox(
                  width: 261,
                  height: 111,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 34, top: 22),
                          child: Text(
                            data['name'],
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
                            data['phone'],
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
                            data['email'],
                            style: const TextStyle(
                                fontFamily: 'Josefin Sans',
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  )));
        }).toList(),
      ),
    );
  }
}
