import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';

class Registered extends StatefulWidget {
  const Registered({Key? key}) : super(key: key);

  @override
  State<Registered> createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('#F1ECE1'),
                HexColor("#A7B79F"),
              ]),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 69),
              child: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/images/talanoa.png',
                  width: 200,
                  height: 297,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 19),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Congrats!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w400,
                      fontSize: 23,
                      color: Colors.black),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                'You have successfully registered',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontWeight: FontWeight.w400,
                    fontSize: 23,
                    color: Colors.black),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 190),
              child: submitButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/');
                  },
                  title: 'Next'),
            )
          ],
        ),
      ),
    );
  }
}
