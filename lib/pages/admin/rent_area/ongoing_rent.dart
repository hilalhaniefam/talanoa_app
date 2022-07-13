import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class RentOngoing extends StatefulWidget {
  const RentOngoing({Key? key}) : super(key: key);
  @override
  State<RentOngoing> createState() => _OngoingState();
}

class _OngoingState extends State<RentOngoing> {
  bool isApicallprocess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('A7B79F'),
      body: ProgressHUD(
        child: Form(
          child: ongoingUI(context),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
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

@override
Widget ongoingUI(BuildContext context) {
  return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('B9C5B2'),
                HexColor('B9C5B2'),
              ],
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 130,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Ongoing',
                style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(5, 5),
                          blurRadius: 15),
                    ],
                    fontFamily: 'Sansation_Bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.black),
              ),
            ),
          ]),
        ),
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
                                  style:
                                      const TextStyle(fontFamily: 'Sansation'),
                                ),
                                subtitle: Text(snapshot.data[i].username),
                                trailing: Text(snapshot.data[i].email));
                          });
                    }
                  }),
            ))
      ]));
}

class User {
  String name, email, username;
  User(this.name, this.email, this.username);
}
