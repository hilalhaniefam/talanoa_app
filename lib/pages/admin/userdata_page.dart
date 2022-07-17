import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';

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
    Response response = await http.get(
        Uri.parse('http://192.168.10.52:5000/users'),
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
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 85, top: 55),
                child: Text(
                  'User Data',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(5, 5),
                            blurRadius: 15),
                      ],
                      fontFamily: 'Josefin_Sans',
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
        padding: EdgeInsets.only(bottom: 29),
        children: users.map((data) {
          return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              shadowColor: Colors.black,
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
        // children: [
      ),
    );
  }
}

//  void updatePass(String password, String confPass, String email) async {
//     try {
//       Response response = await put(
//           Uri.parse('http://192.168.10.52:5000/update-password'),
//           body: {
//             'password': password,
//             'confPassword': confPass,
//             'email': email
//           });
//       print('Update pass:');
//       print(response.body);
//       print(response.statusCode);
//       var data = jsonDecode(response.body.toString());
//       var newData = jsonDecode(jsonEncode(data['payload']));
//       if (response.statusCode == 200) {
//         print('USER:');
//         print(newData);
//         Navigator.of(context)
//             .push(MaterialPageRoute(builder: (context) => const Passupdate()));
//       } else {
//         if (data['message'].isNotEmpty) {
//           throw data['message'];
//         } else {
//           throw data['error'];
//         }
//       }
//     } catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
//     }
//   }

// @override
// Widget userdataUI(BuildContext context) {
//   return SingleChildScrollView(
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//         Container(
//           width: MediaQuery.of(context).size.width,
//           height: MediaQuery.of(context).size.height * 0.25,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 HexColor('B9C5B2'),
//                 HexColor('B9C5B2'),
//               ],
//             ),
//           ),
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             const SizedBox(
//               height: 130,
//             ),
//             Align(
//               alignment: Alignment.center,
//               child: Text(
//                 'User Data',
//                 style: TextStyle(
//                     shadows: [
//                       Shadow(
//                           color: Colors.black.withOpacity(0.3),
//                           offset: const Offset(5, 5),
//                           blurRadius: 15),
//                     ],
//                     fontFamily: 'Sansation_Bold',
//                     fontWeight: FontWeight.w700,
//                     fontSize: 28,
//                     color: Colors.black),
//               ),
//             ),
//           ]),
//         ),
//         const SizedBox(
//           height: 25,
//         ),
//         SizedBox(
//             height: 500,
//             child: Card(
//               child: FutureBuilder(
//                   future: getUserData(),
//                   builder: (context, AsyncSnapshot snapshot) {
//                     if (snapshot.data == null) {
//                       return const Center(child: Text('Loading...'));
//                     } else {
//                       return ListView.builder(
//                           itemCount: snapshot.data.length,
//                           itemBuilder: (context, i) {
//                             return ListTile(
//                                 title: Text(
//                                   snapshot.data[i].name,
//                                   style:
//                                       const TextStyle(fontFamily: 'Sansation'),
//                                 ),
//                                 subtitle: Text(snapshot.data[i].username),
//                                 trailing: Text(snapshot.data[i].email));
//                           });
//                     }
//                   }),
//             ))
//       ]));
// }

// class User {
//   String name, email, username;
//   User(this.name, this.email, this.username);
// }
