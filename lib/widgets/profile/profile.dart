import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  bool isApicallprocess = false;

  String name = '';
  String email = '';
  String phone = '';

  Future<String> getUser() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    print(userData);
    setState(() {
      name = userData['name'];
      email = userData['email'];
      phone = userData['phone'];
    });
    return userData[{'name', 'email', 'phone'}] ?? 'loading';
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  _handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
      backgroundColor: HexColor('#A7B79F').withOpacity(0.9),
      body: ProgressHUD(
        child: Form(
          child: ProfileBody(context, name, email, phone),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget ProfileBody(BuildContext context, name, email, String phone) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(color: HexColor('#B9C5B2')),
          child: const Align(
            alignment: Alignment.center,
            child: Text(
              'Profile Account',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 40, left: 27),
          child: Text(
            'Full Name',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 11,
            left: 27,
            right: 29,
          ),
          child: TextFormField(
            initialValue: name,
            // keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.17, bottom: 12.12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black, width: 2.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            style: const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 11, left: 27),
          child: Text(
            'Email Address',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 11,
            left: 27,
            right: 29,
          ),
          child: TextFormField(
            initialValue: email,
            // keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.17, bottom: 12.12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black, width: 2.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            style: const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 11, left: 27),
          child: Text(
            'Phone Number',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 11,
            left: 27,
            right: 29,
          ),
          child: TextFormField(
            initialValue: phone,
            // keyboardType: const TextInputType.numberWithOptions(),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 16, top: 12.17, bottom: 12.12),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Colors.black, width: 2.0)),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black, width: 2.0),
              ),
            ),
            style: const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
          ),
        ),
      ],
    ),
  );
}