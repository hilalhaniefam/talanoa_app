import 'dart:convert';
// import 'dart:js';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
// import 'package:talanoa_app/main.dart';
import 'package:talanoa_app/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginUI extends StatefulWidget {
  const LoginUI({Key? key}) : super(key: key);

  @override
  State<LoginUI> createState() => LoginUIState();
}

class LoginUIState extends State<LoginUI> {
  bool hidePassword = true;
  String email = '';
  String password = '';

  TextEditingController emailCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();

  void login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse('http://192.168.0.126:5000/login'),
          body: {'email': email, 'password': password});
      print(response.body);
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', jsonEncode(data));
        Map<String, dynamic> userData =
            jsonDecode(sharedPreferences.getString('userData').toString())
                as Map<String, dynamic>;
        if (userData['role'] == 1) {
          Navigator.pushReplacementNamed(context, '/user');
        } else if (userData['role'] == 2) {
          Navigator.pushReplacementNamed(context, '/admin');
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
    return SingleChildScrollView(
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
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 50,
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
                  // keyboardType: const TextInputType.numberWithOptions(),
                  controller: emailCon,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 16, top: 12.17, bottom: 12.12),
                    labelText: 'Email',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  style:
                      const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 16.17,
                  left: 44,
                  right: 43,
                ),
                child: TextFormField(
                  // keyboardType: const TextInputType.numberWithOptions(),
                  controller: passwordCon,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 16, top: 12.17, bottom: 12.12),
                    labelText: 'Password',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.black, width: 2.0)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                  ),
                  style:
                      const TextStyle(fontFamily: 'Josefin Sans', fontSize: 17),
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
                              Navigator.pushNamed(context, '/resetpass');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 90,
              ),
              SizedBox(
                width: 150,
                height: 40,
                child: FormHelper.submitButton(
                  "Login",
                  () {
                    login(
                      emailCon.text.toString(),
                      passwordCon.text.toString(),
                    );
                  },
                  btnColor: HexColor("#F1ECE1"),
                  borderColor: Colors.grey,
                  txtColor: Colors.black,
                  borderRadius: 10,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "OR",
                style: TextStyle(
                    fontFamily: "Josefin Sans", fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                      children: <TextSpan>[
                        const TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(
                            fontFamily: 'Josefin Sans',
                            color: Colors.black,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, '/register');
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
    );
  }
}
