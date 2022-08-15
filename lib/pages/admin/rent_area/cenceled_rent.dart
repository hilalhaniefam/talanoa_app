import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class Rentareacenceled extends StatefulWidget {
  const Rentareacenceled({Key? key}) : super(key: key);
  @override
  State<Rentareacenceled> createState() => _CenceledState();
}

class _CenceledState extends State<Rentareacenceled> {
  bool isApicallprocess = false;
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdmin(backButton: _handleBack, title: 'Cenceled'),
        backgroundColor: HexColor('A7B79F'),
        body: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                  height: 500,
                  child: Card(
                    child: FutureBuilder(
                        future: getUserData(),
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return const Center(child: Text('Loading...'));
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, i) {
                                  return ListTile(
                                      title: Text(
                                        snapshot.data[i].name,
                                        style: const TextStyle(
                                            fontFamily: 'Sansation'),
                                      ),
                                      subtitle: Text(snapshot.data[i].username),
                                      trailing: Text(snapshot.data[i].email));
                                });
                          }
                        }),
                  ))
            ])));
  }
}

getUserData() async {
  var response = await http.get(
    Uri.https('jsonplaceholder.typicode.com', 'users'),
  );
  var jsonData = jsonDecode(response.body);
  List<User> users = [];

  for (var u in jsonData) {
    User user = User(u['name'], u['email'], u['username']);
    users.add(user);
  }
  // ignore: avoid_print
  print(users.length);
  return users;
}

class User {
  String name, email, username;
  User(this.name, this.email, this.username);
}
