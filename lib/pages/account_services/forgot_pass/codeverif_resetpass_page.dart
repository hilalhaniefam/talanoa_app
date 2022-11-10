import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/account_services/forgot_pass/newpass_page.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class CodeVerifResetPassPage extends StatefulWidget {
  final String email;
  final String userId;
  const CodeVerifResetPassPage(this.email, this.userId, {Key? key})
      : super(key: key);
  @override
  State<CodeVerifResetPassPage> createState() => _CodeVerifResetPassPageState();
}

class _CodeVerifResetPassPageState extends State<CodeVerifResetPassPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Duration duration = const Duration(seconds: 120);
  Timer? timer;
  _handleBack() => Navigator.of(context).pop();
  String otp = '';
  TextEditingController otpCon = TextEditingController();

  void sendOtpForgotPass(String email) async {
    try {
      Response response =
          await post(Uri.parse('$ipurl/send-otp-forgot-pass'), body: {
        'email': email,
      });
      print('SEND OTP:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', data['payload'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message'].toString()));
        setState(() {
          resetTimer();
        });
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

  void verifyOtpForgotPass(String otp, String userId) async {
    try {
      Response response =
          await post(Uri.parse('$ipurl/verify-otp-forgot-pass'), body: {
        'userId': userId,
        'otp': otp,
      });
      print('VERIFY OTP:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());

      print('user ni');
      print(data);
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'otpForgotPass', data['payload'].toString());
        var user = jsonDecode(jsonEncode(data['payload']['user']));
        print('USER:');
        print(user);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => NewpassPage(user['email'])));
      } else {
        if (data['message'].isNotEmpty) {
          throw data['message'];
        } else {
          throw data['error'];
        }
      }
    } catch (e) {
      print('error');
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  void startTimer() {
    const count = Duration(seconds: 1);
    timer = Timer.periodic(count, (timer) {
      if (duration.inSeconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          final seconds = duration.inSeconds + -1;
          duration = Duration(seconds: seconds);
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void resetTimer() {
    setState(() {
      duration = const Duration(minutes: 2);
      startTimer();
    });
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return Text(
      '$minutes:$seconds minutes',
    );
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
                  height: 70,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
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
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                    child: Text(
                      'Enter the verification code sent to ${widget.email}',
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: HexColor('#484848'),
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
                    ),
                    child: buildTime(),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                submitButton(
                    onTap: () {
                      verifyOtpForgotPass(otpCon.text, widget.userId);
                    },
                    title: 'Verify Code'),
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
                            text: 'Resend Code',
                            style: const TextStyle(
                              fontFamily: 'Josefin Sans',
                              color: Colors.black,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                sendOtpForgotPass(widget.email);
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
