import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Passupdate extends StatefulWidget {
  const Passupdate({Key? key}) : super(key: key);

  @override
  State<Passupdate> createState() => _PassupdateState();
}

class _PassupdateState extends State<Passupdate> {
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
                  height: 167,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'PASSWORD  UPDATED',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 40,
                        color: HexColor('#010101')),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/centang.png',
                    width: 153,
                    height: 156,
                  ),
                ),
                const SizedBox(
                  height: 38.5,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Your password has been updated!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 17,
                        color: HexColor('#3D3D3D')),
                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                SizedBox(
                  width: 311,
                  height: 58,
                  child: FormHelper.submitButton(
                    "Login",
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
