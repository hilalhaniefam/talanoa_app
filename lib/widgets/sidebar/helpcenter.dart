import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Helpcenter extends StatefulWidget {
  const Helpcenter({Key? key}) : super(key: key);

  @override
  State<Helpcenter> createState() => _AboutusState();
}

class _AboutusState extends State<Helpcenter> {
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
          child: HelpcenterBody(context),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget HelpcenterBody(BuildContext context) {
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
                'Help Center',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ),
      ],
    ),
  );
}
