import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter/gestures.dart';
import 'package:http/http.dart';
import 'package:talanoa_app/pages/account_services/new_account/codeverif_newacc_page.dart';
import 'package:talanoa_app/pages/account_services/new_account/register_page.dart';
import 'package:talanoa_app/pages/account_services/forgot_pass/forgotpass_page.dart';
import 'package:talanoa_app/pages/admin/admin_page.dart';
import 'package:talanoa_app/pages/user/user_page.dart';
import 'package:talanoa_app/widgets/form_account_services/form_login.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/linear_gradient.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
        if (errorFormStatus[key]) throw 'Please complete the form!';
      }
      Response response = await post(Uri.parse('$ipurl/login'),
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
            child: Builder(
                builder: (context) => Center(
                        child: SingleChildScrollView(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                          linearGradient(
                            context: context,
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
                                  formLogin(
                                      emailCon: formValue['email'],
                                      emailonChanged: (value) {
                                        setState(() {
                                          errorFormStatus['email'] = false;
                                        });
                                      },
                                      emailerrorText: errorFormStatus['email']
                                          ? 'Please enter your email'
                                          : null,
                                      passCon: formValue['password'],
                                      passonChanged: (value) {
                                        setState(() {
                                          errorFormStatus['password'] = false;
                                        });
                                      },
                                      passerrorText: errorFormStatus['password']
                                          ? 'Please enter your password'
                                          : null),
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
                                                decoration:
                                                    TextDecoration.underline,
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
                                  submitButton(
                                      onTap: () {
                                        final progress =
                                            ProgressHUD.of(context);
                                        progress?.show();
                                        Future.delayed(
                                            const Duration(seconds: 2), () {
                                          progress?.dismiss();
                                        });
                                        login(
                                          formValue['email']
                                              .text
                                              .toString()
                                              .toLowerCase(),
                                          formValue['password'].text.toString(),
                                        );
                                      },
                                      title: 'Login'),
                                  const Padding(
                                      padding:
                                          EdgeInsets.only(top: 10, bottom: 10),
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
                                                text:
                                                    'Don\'t have an account? '),
                                            TextSpan(
                                              text: "Sign Up",
                                              style: const TextStyle(
                                                fontFamily: 'Josefin Sans',
                                                color: Colors.black,
                                                decoration:
                                                    TextDecoration.underline,
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
                          )
                        ]))))));
  }
}
