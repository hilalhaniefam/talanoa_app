import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Registered extends StatefulWidget {
  const Registered({Key? key}) : super(key: key);

  @override
  State<Registered> createState() => _RegisteredState();
}

class _RegisteredState extends State<Registered> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
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
                const SizedBox(
                  height: 109,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/talanoa.png',
                    width: 200,
                    height: 297,
                  ),
                ),
                const SizedBox(
                  height: 38.5,
                ),
                const Align(
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
                const Padding(
                  padding: EdgeInsets.only(top: 10),
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
                const SizedBox(
                  height: 200,
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: FormHelper.submitButton(
                    "Next",
                    () {
                      Navigator.pushNamed(context, '/');
                    },
                    btnColor: HexColor("#F1ECE1"),
                    borderColor: Colors.grey,
                    txtColor: Colors.black,
                    borderRadius: 10,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
