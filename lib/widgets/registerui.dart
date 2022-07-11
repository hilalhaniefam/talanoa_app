import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/codeverif.dart';
import 'package:talanoa_app/widgets/snackbar.dart';

class RegisterUI extends StatefulWidget {
  const RegisterUI({Key? key}) : super(key: key);

  @override
  State<RegisterUI> createState() => RegisterUIState();
}

class RegisterUIState extends State<RegisterUI> {
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  Map formValue = {
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confPass': TextEditingController(),
    'name': TextEditingController(),
    'phone': TextEditingController()
  };

  Map errorFormStatus = {
    'email': false,
    'password': false,
    'confPass': false,
    'name': false,
    'phone': false
  };

  void resetValidation() {
    for (String key in errorFormStatus.keys) {
      errorFormStatus[key] = false;
    }
  }

  _handleBack() => Navigator.of(context).pop();

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

  bool validatePass(String value) {
    RegExp passvalid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
    if (passvalid.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  void register(String name, String email, String phone, String password,
      String confPassword) async {
    try {
      for (String key in errorFormStatus.keys) {
        validateTextField(key);
      }

      for (String key in errorFormStatus.keys) {
        if (errorFormStatus[key]) throw 'Please complete the form';
      }
      Response response =
          await post(Uri.parse('http://192.168.0.126:5000/register'), body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confPassword': confPassword,
      });
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      var newUser = jsonDecode(jsonEncode(data['newUser']));
      print('data');
      print(newUser['userId']);
      if (response.statusCode == 200) {
        // SharedPreferences sharedPreferences =
        //     await SharedPreferences.getInstance();
        // sharedPreferences.setString('userData', data.toString());
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CodeVerifPage(formValue['email'].text, newUser['userId'])));
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
            child: Form(
          key: globalFormKey,
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
                        controller: formValue['name'],
                        onChanged: (value) {
                          for (String key in errorFormStatus.keys) {
                            setState(() {
                              errorFormStatus[key] = false;
                            });
                          }
                        },
                        //   globalFormKey.currentState!.validate();
                        // },
                        // validator: (value) {
                        //   if (value!.isEmpty) {
                        //     return 'Please enter your name';
                        //   }
                        // },
                        decoration: InputDecoration(
                          label: const Text.rich(
                            TextSpan(children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  'Name',
                                ),
                              ),
                            ]),
                          ),
                          errorText: errorFormStatus['name']
                              ? 'Please enter your name'
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
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
                        onChanged: (value) {
                          final form = globalFormKey.currentState!;
                          if (form.validate()) {}
                          for (String key in errorFormStatus.keys) {
                            setState(() {
                              errorFormStatus[key] = false;
                            });
                          }
                        },
                        validator: (value) =>
                            value != null && !EmailValidator.validate(value)
                                ? 'Enter a Valid Email'
                                : null,
                        controller: formValue['email'],
                        decoration: InputDecoration(
                          label: const Text.rich(
                            TextSpan(children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  'Email',
                                ),
                              ),
                            ]),
                          ),
                          errorText: errorFormStatus['email']
                              ? 'Please enter your email'
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
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
                        onChanged: (value) {
                          for (String key in errorFormStatus.keys) {
                            setState(() {
                              errorFormStatus[key] = false;
                            });
                          }
                        },
                        keyboardType: const TextInputType.numberWithOptions(),
                        controller: formValue['phone'],
                        decoration: InputDecoration(
                          prefixText: '+62 ',
                          label: const Text.rich(
                            TextSpan(children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  'Phone',
                                ),
                              ),
                            ]),
                          ),
                          errorText: errorFormStatus['phone']
                              ? 'Please enter your phone number'
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
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
                        onChanged: (value) {
                          globalFormKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (!validatePass(value)) {
                            return 'Password is too weak!';
                          }
                          return null;
                        },
                        controller: formValue['password'],
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          label: const Text.rich(
                            TextSpan(children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  'Password',
                                ),
                              ),
                            ]),
                          ),
                          errorText: errorFormStatus['password']
                              ? 'Please enter password'
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
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
                        onChanged: (value) {
                          globalFormKey.currentState!.validate();
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please re-enter your password';
                          }
                          if (value != formValue['password'].text) {
                            return 'Password not match';
                          }
                          return null;
                        },
                        controller: formValue['confPass'],
                        obscureText: hidePassword,
                        decoration: InputDecoration(
                          label: const Text.rich(
                            TextSpan(children: <InlineSpan>[
                              WidgetSpan(
                                child: Text(
                                  'Confirm Password',
                                ),
                              ),
                            ]),
                          ),
                          errorText: errorFormStatus['confPass']
                              ? 'Please re-enter password'
                              : null,
                          errorStyle: const TextStyle(
                            fontSize: 11,
                          ),
                          contentPadding: const EdgeInsets.only(
                              left: 16, top: 12.17, bottom: 12.12),
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
                            formValue['name']!.text.toString(),
                            formValue['email']!.text.toString(),
                            formValue['phone']!.text.toString(),
                            formValue['password']!.text.toString(),
                            formValue['confPass']!.text.toString(),
                          );
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
        )));
  }
}
