import 'dart:convert';
// import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/snackbar.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key}) : super(key: key);

  @override
  State<RegisterUI> createState() => RegisterUIState();
}

class RegisterUIState extends State<RegisterUI> {
  bool hidePassword = true;
  late String email, password, confPass, name, phone;
  _handleBack() => Navigator.of(context).pop();

  // bool isConfpassValidate = false;
  // bool validateTextField(String confPass) {
  //   if (confPass.isEmpty) {
  //     setState(() {
  //       isConfpassValidate = true;
  //     });
  //     return false;
  //   }
  //   setState(() {
  //     isConfpassValidate = false;
  //   });
  //   return true;
  // }
  // final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneCon = TextEditingController();
  TextEditingController passwordCon = TextEditingController();
  TextEditingController nameCon = TextEditingController();
  TextEditingController confirmpass = TextEditingController();

  void register(String name, String email, String phone, String password,
      String confPassword) async {
    try {
      // if (password != confPass) {}
      Response response =
          await post(Uri.parse('http://10.137.209.146:5000/register'), body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confPassword': confPassword,
      });
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
  Widget build(BuildContext context) {
    return Scaffold(
        // extendBodyBehindAppBar: true,
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
                        controller: nameCon,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Full Name can't be empty";
                          }

                          return null;
                        },
                        onSaved: (name) {
                          name;
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          hintText: 'Full Name',
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
                            fontFamily: 'Josefin Sans', fontSize: 15),
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
                          hintText: 'Email Address',
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
                            fontFamily: 'Josefin Sans', fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 44,
                        right: 43,
                      ),
                      child: TextFormField(
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: phoneCon,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          hintText: 'Phone Number',
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
                            fontFamily: 'Josefin Sans', fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.17,
                        left: 44,
                        right: 43,
                      ),
                      child: TextFormField(
                        // keyboardType: const TextInputType.numberWithOptions(),
                        controller: passwordCon,
                        obscureText: hidePassword,
                        // validator: (value) {
                        //   confirmPass = value;
                        //   if (value!.isEmpty) {
                        //     return "Please Enter Password";
                        //   } else if (value.length < 8) {
                        //     return "Password must be atleast 8 characters long";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          hintText: 'Password',
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
                            fontFamily: 'Josefin Sans', fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16.17,
                        left: 44,
                        right: 43,
                      ),
                      child: TextFormField(
                        // keyboardType: const TextInputType.numberWithOptions(),
                        controller: confirmpass,
                        obscureText: hidePassword,
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return "Please Re-Enter New Password";
                        //   } else if (value.length < 8) {
                        //     return "Password must be atleast 8 characters long";
                        //   } else if (value != confirmPass) {
                        //     return "Password must be same as above";
                        //   } else {
                        //     return null;
                        //   }
                        // },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
                          hintText: 'Confirm Password',
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
                            fontFamily: 'Josefin Sans', fontSize: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Center(
                      child: FormHelper.submitButton(
                        "Sign Up",
                        () {
                          register(
                              nameCon.text.toString(),
                              emailCon.text.toString(),
                              phoneCon.text.toString(),
                              passwordCon.text.toString(),
                              confirmpass.text.toString());
                        },
                        btnColor: HexColor("#F1ECE1"),
                        borderColor: Colors.grey,
                        txtColor: Colors.black,
                        borderRadius: 10,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
