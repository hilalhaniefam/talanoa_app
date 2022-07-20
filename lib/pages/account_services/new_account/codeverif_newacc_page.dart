import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/pages/account_services/new_account/account_registered_pages.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class CodeVerifAccPage extends StatefulWidget {
  final String email;
  final String userId;
  const CodeVerifAccPage(this.email, this.userId, {Key? key}) : super(key: key);
  @override
  State<CodeVerifAccPage> createState() => _CodeVerifAccountPageState();
}

class _CodeVerifAccountPageState extends State<CodeVerifAccPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  _handleBack() => Navigator.of(context).pop();
  String otp = '';
  TextEditingController otpCon = TextEditingController();

  void sendOtp(String email) async {
    try {
      Response response = await post(Uri.parse('$ipurl/send-otp'), body: {
        'email': email,
      });
      print('SEND OTP:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('otpNewUser', data['payload'].toString());
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

  void verifyOtp(String otp, String userId) async {
    try {
      Response response = await post(Uri.parse('$ipurl/verify-otp'), body: {
        'userId': userId,
        'otp': otp,
      });
      print('VERIFY OTP:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('otpNewUser', data['payload'].toString());
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Registered()));
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
    sendOtp(widget.email);
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
                    'CODE VERIFICATION',
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
                      'You will recive an email with a verification code for double security',
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
                    controller: otpCon,
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
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 7.17,
                      right: 34,
                    ),
                    child: RichText(
                      text: const TextSpan(
                        text: '2:00 minutes',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: 150,
                  height: 40,
                  child: FormHelper.submitButton(
                    "Verify Code",
                    () {
                      verifyOtp(otpCon.text, widget.userId);
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
                              ..onTap = () {
                                sendOtp(widget.email);
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
