import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _Profile();
}

class _Profile extends State<Profile> {
  bool isApicallprocess = false;
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
          child: HistoryBody(context),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget HistoryBody(BuildContext context) {
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
              'Profile',
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
