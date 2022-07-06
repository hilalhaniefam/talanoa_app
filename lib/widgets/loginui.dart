import 'dart:convert';
// import 'dart:js';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/user/userpage.dart';
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
  late String email, password;
  // bool _isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login(String email, password) async {
    try {
      Response response = await post(
          Uri.parse('http://10.113.179.128:8081/api/account/login'),
          body: {'email': email, 'password': password});
      print(response.body);
      print(response.statusCode);
      Map<String, dynamic> data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userData', jsonEncode(data));
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => const UserPage()));
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
                  controller: emailController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 16, top: 12.17, bottom: 12.12),
                    hintText: '' 'Email',
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
                  controller: passwordController,
                  obscureText: hidePassword,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        left: 16, top: 12.17, bottom: 12.12),
                    hintText: '' 'Password',
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
              Center(
                child: FormHelper.submitButton(
                  "Login",
                  () {
                    // setState(() {
                    //   _isLoading = true;
                    // });
                    login(emailController.text.toString(),
                        passwordController.text.toString());
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

// child: FormHelper.inputFieldWidget(
          //   context,
          //   "nohp",
          //   "No. Handphone",
          //   (onVaLidateVal) {
          //     if (onVaLidateVal.isEmpty) {
          //       return "No. Handphone can't be empty";
          //     }

          //     return null;
          //   },
          //   (onSavedVal) {
          //     nohp = onSavedVal;
          //   },
          //   borderFocusColor: Colors.black,
          //   borderColor: Colors.black,
          //   textColor: Colors.black,
          //   hintColor: Colors.black.withOpacity(0.7),
          //   borderWidth: 288,
          //   borderRadius: 10,
          // )),

          // child: FormHelper.inputFieldWidget(
            //     context, 'password', 'Password', (onVaLidateVal) {
            //   if (onVaLidateVal.isEmpty) {
            //     return "Password can't be empty";
            //   }

            //   return null;
            // }, (onSavedVal) {
            //   password = onSavedVal;
            // },
            //     borderFocusColor: Colors.black,
            //     borderColor: Colors.black,
            //     textColor: Colors.black,
            //     hintColor: Colors.black.withOpacity(0.7),
            //     borderWidth: 288,
            //     borderRadius: 10,
            //     obscureText: hidePassword,
            //     suffixIcon: IconButton(
            //         onPressed: () {
            //           setState(() {
            //             hidePassword = !hidePassword;
            //           });
            //         },
            //         color: Colors.black.withOpacity(0.7),
            //         icon: Icon(hidePassword
            //             ? Icons.visibility_off
            // : Icons.visibility))),

                      // OutlinedButton(
          //   style: OutlinedButton.styleFrom(
          //     shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10)),
          //     minimumSize: const Size(287, 39.83),
          //     textStyle: const TextStyle(
          //         fontFamily: 'Sansation_Regular', fontSize: 20),
          //     primary: Colors.black,
          //     side: const BorderSide(width: 2, color: Colors.black),
          //     // onPrimary: Colors.black,
          //   ),
          //   onPressed: () {
          //     login(emailController.text.toString(),
          //         passwordController.text.toString());
          //   },
          //   child: const Text('Login'),
          // ),