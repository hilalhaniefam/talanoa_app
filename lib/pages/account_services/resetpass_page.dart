import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/account_services/codeverif_resetpass_page.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({Key? key}) : super(key: key);

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  bool isApicallprocess = false;
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
    try {
      if (emailCon.text.isEmpty) {
        validateTextField(emailCon.text);
      } else {
        Response response = await post(
            Uri.parse('http://192.168.10.52:5000/send-otp-forgot-pass'),
            body: {
              'userId': userId,
              'email': email,
            });
        print('SEND OTP:');
        print(response.body);
        print(response.statusCode);
        var data = jsonDecode(response.body.toString());
        var verifiedUser = jsonDecode(jsonEncode(data['data']));
        if (response.statusCode == 200) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString(
              'userData', data['verifiedUser'].toString());
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
        body: ProgressHUD(
            inAsyncCall: isApicallprocess,
            key: formKey,
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
                        const Padding(
                          padding: EdgeInsets.only(top: 139, right: 115),
                          child: Text(
                            'FORGOT PASSWORD',
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
                              padding:
                                  const EdgeInsets.fromLTRB(30, 20, 20, 13),
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
                          padding: const EdgeInsets.only(left: 31, right: 32),
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
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                errorText: isEmailValidate
                                    ? 'Please enter your email'
                                    : null),
                            style: const TextStyle(
                                fontFamily: 'Josefin Sans', fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: FormHelper.submitButton(
                            "SEND",
                            () {
                              sendOtpForgotPass(
                                emailCon.text.toString(),
                                userId,
                              );
                              // Navigator.pushNamed(context, '/codeverif');
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
                ]))));
  }
}
