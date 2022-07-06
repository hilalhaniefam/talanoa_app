import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class ResetpassUI extends StatefulWidget {
  const ResetpassUI({Key? key}) : super(key: key);

  @override
  State<ResetpassUI> createState() => _ResetpassUIState();
}

class _ResetpassUIState extends State<ResetpassUI> {
  final _formKey = GlobalKey<FormState>();
  bool isEmailValidate = false;
  bool validateTextField(String email) {
    if (email.isEmpty) {
      setState(() {
        isEmailValidate = true;
      });
      return false;
    }
    setState(() {
      isEmailValidate = false;
    });
    return true;
  }

  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
            key: _formKey,
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
                  height: 130,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '    FORGOT PASSWORD',
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                  child: Text(
                    'Provide your email address for which you want to reset your password',
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: HexColor('#3D3D3D'),
                    ),
                  ),
                )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                      child: Text(
                        'Please enter your email address',
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: HexColor('#1A1A1A'),
                        ),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 32, right: 32),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 16, top: 12.17, bottom: 12.12),
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                        ),
                        errorText:
                            isEmailValidate ? 'Please enter a Email' : null),
                    style: const TextStyle(
                        fontFamily: 'Josefin Sans', fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 311,
                  height: 58,
                  child: FormHelper.submitButton(
                    "SEND",
                    () {
                      validateTextField(emailController.text);
                      Navigator.pushNamed(context, '/codeverif');
                    },
                    btnColor: HexColor("#F1ECE1"),
                    borderColor: Colors.grey,
                    txtColor: Colors.black,
                    borderRadius: 10,
                    fontSize: 20,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 27,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Cancel',
                            style: const TextStyle(
                              fontFamily: 'Josefin Sans',
                              color: Colors.black,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]));
  }
}
