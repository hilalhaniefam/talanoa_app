import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/account_services/new_account/codeverif_newacc_page.dart';
import 'package:talanoa_app/pages/account_services/new_account/register_page.dart';
import 'package:talanoa_app/pages/account_services/resetpass_page.dart';
import 'package:talanoa_app/pages/admin/admin_page.dart';
import 'package:talanoa_app/pages/user/user_page.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApicallprocess = false;
  bool hidePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = true;
  Map formValue = {
    'email': TextEditingController(),
    'password': TextEditingController(),
  };
  Map errorFormStatus = {'email': false, 'password': false};
  bool validateTextField(String formKey) {
    if (formValue[formKey].text.trim().isEmpty) {
      setState(() {
        errorFormStatus[formKey] = true;
      });
      return true;
    }
    setState(() {
      errorFormStatus[formKey] = false;
    });
    return false;
  }

  void login(String email, String password) async {
    try {
      for (String key in errorFormStatus.keys) {
        validateTextField(key);
      }
      for (String key in errorFormStatus.keys) {
        if (errorFormStatus[key]) throw 'Please enter your email and password';
      }
      Response response = await post(
          Uri.parse('http://192.168.10.52:5000/login'),
          body: {'email': email, 'password': password});
      print(response.body);
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', jsonEncode(data['payload']));
        Map<String, dynamic> userData =
            jsonDecode(sharedPreferences.getString('userData').toString())
                as Map<String, dynamic>;
        print(userData);
        if (userData['role'] == 1) {
          if (userData['isVerified'] == true) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const UserPage()));
          } else if (userData['isVerified'] == false) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CodeVerifAccPage(
                    formValue['email'].text, userData['userId'])));
          }
        }
        if (userData['role'] == 2) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const AdminPage()));
        }
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
  Widget build(BuildContext context) {
    return Scaffold(
        body: ProgressHUD(
            key: formKey,
            inAsyncCall: false,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(
                              'assets/images/talanoa.png',
                              width: 170,
                              height: 227,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 20,
                              left: 44,
                              right: 43,
                            ),
                            child: TextFormField(
                              controller: formValue['email'],
                              onChanged: (value) {
                                setState(() {
                                  errorFormStatus['email'] = false;
                                });
                              },
                              decoration: InputDecoration(
                                errorText: errorFormStatus['email']
                                    ? 'Please enter your email'
                                    : null,
                                errorStyle: const TextStyle(
                                  fontSize: 11,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 16, top: 12.17, bottom: 12.12),
                                labelText: 'Email',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Josefin Sans', fontSize: 17),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                              top: 16.17,
                              left: 44,
                              right: 43,
                            ),
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  errorFormStatus['password'] = false;
                                });
                              },
                              controller: formValue['password'],
                              obscureText: true,
                              decoration: InputDecoration(
                                errorText: errorFormStatus['password']
                                    ? 'Please enter your password'
                                    : null,
                                errorStyle: const TextStyle(
                                  fontSize: 11,
                                ),
                                contentPadding: const EdgeInsets.only(
                                    left: 16, top: 12.17, bottom: 12.12),
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                              ),
                              style: const TextStyle(
                                  fontFamily: 'Josefin Sans', fontSize: 17),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 7.17,
                                right: 48,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: 'Forgot Password?',
                                      style: const TextStyle(
                                        fontFamily: 'Josefin Sans',
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const ResetpassPage()));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                          SizedBox(
                            width: 150,
                            height: 45,
                            child: FormHelper.submitButton(
                              "Login",
                              () {
                                login(
                                  formValue['email']
                                      .text
                                      .toString()
                                      .toLowerCase(),
                                  formValue['password'].text.toString(),
                                );
                              },
                              btnColor: HexColor("#F1ECE1"),
                              borderColor: Colors.grey,
                              txtColor: Colors.black,
                              borderRadius: 10,
                              fontSize: 20,
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                "OR",
                                style: TextStyle(
                                    fontFamily: "Josefin Sans",
                                    fontWeight: FontWeight.bold),
                              )),
                          Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 7.17,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400),
                                  children: <TextSpan>[
                                    const TextSpan(
                                        text: 'Don\'t have an account? '),
                                    TextSpan(
                                      text: "Sign Up",
                                      style: const TextStyle(
                                        fontFamily: 'Josefin Sans',
                                        color: Colors.black,
                                        decoration: TextDecoration.underline,
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext
                                                          context) =>
                                                      const RegisterPage()));
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ],
              ),
            )));
  }
}
