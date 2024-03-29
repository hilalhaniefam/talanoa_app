import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/account_services/forgot_pass/codeverif_resetpass_page.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({Key? key}) : super(key: key);

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  String userId = '';
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

  void sendOtpForgotPass(String email, String userId) async {
    //delete userId
    try {
      if (emailCon.text.isEmpty) {
        validateTextField(emailCon.text);
      } else {
        Response response =
            await post(Uri.parse('$ipurl/send-otp-forgot-pass'), body: {
          'email': email,
        });
        print('SEND OTP:');
        print(response.body);
        print(response.statusCode);
        var data = jsonDecode(response.body.toString());
        var verifiedUser = jsonDecode(jsonEncode(data['payload']));
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'otpForgotPassData', data['payload'].toString());
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => CodeVerifResetPassPage(
                  emailCon.text, verifiedUser['userId'])));
        } else {
          if (data['message'].isNotEmpty) {
            throw data['message'];
          } else {
            throw data['error'];
          }
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#E5E5E5'),
        body: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.only(left: 30, right: 20),
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
                  height: 110,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'FORGOT PASSWORD',
                    style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w700,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                    child: Text(
                      'Please enter your email address',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: HexColor('#1A1A1A'),
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: TextFormField(
                    controller: emailCon,
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
                            isEmailValidate ? 'Please enter your email' : null),
                    style: const TextStyle(
                        fontFamily: 'Josefin Sans', fontSize: 17),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                submitButton(
                    onTap: () {
                      sendOtpForgotPass(
                        emailCon.text.toString(),
                        userId,
                      );
                    },
                    title: 'SEND'),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 20,
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
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pop();
                              },
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
