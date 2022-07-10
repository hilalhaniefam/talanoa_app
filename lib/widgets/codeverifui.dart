import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/snackbar.dart';

import '../pages/codeverif.dart';

class CodeverifUI extends StatefulWidget {
  final String email;
  final int user_id;
  const CodeverifUI(this.email, this.user_id, {Key? key}) : super(key: key);

  @override
  State<CodeverifUI> createState() => _CodeverifUIState();
}

class _CodeverifUIState extends State<CodeverifUI> {
  final _formKey = GlobalKey<FormState>();
  _handleBack() => Navigator.of(context).pop();
  Widget buildPinPut() {
    return Pinput(
      onCompleted: (pin) => print(pin),
    );
  }

  void sendOtp(String email, int user_id) async {
    //user_id ganti ke String
    try {
      Response response =
          await post(Uri.parse('http://192.168.1.100:5000/sendOtp'), body: {
        'user_id': user_id.toString(),
        'email': email,
      });
      print('SEND OTP:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', data.toString());
      } else {
        if (data['message'].isNotEmpty) {
          throw data['message'];
        } else {
          throw data['error'];
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  @override
  void initState() {
    super.initState();
    sendOtp(widget.email, widget.user_id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: HexColor('#F1ECE1'),
        ),
        body: SingleChildScrollView(
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
                      height: 70,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 107),
                      child: Text(
                        'CODE VERIFIVATION',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w700,
                            fontSize: 25,
                            color: Colors.black),
                      ),
                    ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                        child: Text(
                          'You will recive an email with a verification code to reset your password',
                          style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: HexColor('#3D3D3D'),
                          ),
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 10, 20, 20),
                          child: Text(
                            'Enter the verification code sent to ${widget.email}',
                            style: TextStyle(
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w400,
                              fontSize: 18,
                              color: HexColor('#484848'),
                            ),
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Pinput(
                        length: 6,
                        defaultPinTheme: PinTheme(
                          width: 56,
                          height: 56,
                          textStyle: const TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'Josefin Sans',
                              fontWeight: FontWeight.w400),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                color: Colors.black,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                      width: 311,
                      height: 58,
                      child: FormHelper.submitButton(
                        "Verify Code",
                        () {
                          Navigator.pushNamed(context, '/newpass');
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
                          top: 38,
                        ),
                        child: RichText(
                          text: TextSpan(
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Resend Code',
                                style: const TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  color: Colors.black,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }
}
