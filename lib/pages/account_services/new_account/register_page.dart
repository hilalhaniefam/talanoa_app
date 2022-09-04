import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/pages/account_services/new_account/codeverif_newacc_page.dart';
import 'package:talanoa_app/widgets/shared/linear_gradient.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  bool isApicallprocess = false;
  bool hidePassword = true;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  bool validatePass(String pass) {
    RegExp passvalid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
    if (passvalid.hasMatch(pass)) {
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

      if (formKey.currentState!.validate() == false) {
        throw 'Please complete the form!';
      }

      List<String> phoneArr = phone.split('');
      if (phoneArr[0] == '0') {
        phoneArr.removeAt(0);
        phone = phoneArr.join();
        phone = '+62' + phone;
      } else {
        phone = '+62' + phone;
      }

      for (String key in errorFormStatus.keys) {
        if (errorFormStatus[key]) throw 'Please complete the form';
      }
      Response response = await post(Uri.parse('$ipurl/register'), body: {
        'name': name,
        'email': email,
        'phone': phone,
        'password': password,
        'confPassword': confPassword,
      });
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      var newUser = jsonDecode(jsonEncode(data['payload']));
      print(newUser);
      if (response.statusCode == 200) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                CodeVerifAccPage(formValue['email'].text, newUser['userId'])));
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
        body: ProgressHUD(
          child: Builder(builder: (context) {
            return Center(
              child: linearGradient(
                  child: SingleChildScrollView(
                      child: Form(
                    key: formKey,
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
                              setState(() {
                                errorFormStatus['name'] = false;
                              });
                            },
                            decoration: InputDecoration(
                              label: const Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Text(
                                      'Full Name',
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
                              setState(() {
                                errorFormStatus['email'] = false;
                              });
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
                                      'Email Address',
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
                            keyboardType:
                                const TextInputType.numberWithOptions(),
                            controller: formValue['phone'],
                            onChanged: (value) {
                              setState(() {
                                errorFormStatus['phone'] = false;
                              });
                            },
                            decoration: InputDecoration(
                              prefixText: '+62 ',
                              label: const Text.rich(
                                TextSpan(children: <InlineSpan>[
                                  WidgetSpan(
                                    child: Text(
                                      'Phone Number',
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
                              setState(() {
                                errorFormStatus['password'] = false;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your password';
                              } else {
                                bool result = validatePass(value);
                                if (result) {
                                  return null;
                                } else {
                                  return 'Password is too weak!';
                                }
                              }
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
                              setState(() {
                                errorFormStatus['confPass'] = false;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please re-enter your password';
                              }
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
                          child: submitButton(
                              onTap: () async {
                                final progress = ProgressHUD.of(context);
                                progress?.show();
                                Future.delayed(const Duration(seconds: 2), () {
                                  progress?.dismiss();
                                });
                                register(
                                  formValue['name']!.text.toString(),
                                  formValue['email']!
                                      .text
                                      .toString()
                                      .toLowerCase(),
                                  formValue['phone']!.text.toString(),
                                  formValue['password']!.text.toString(),
                                  formValue['confPass']!.text.toString(),
                                );
                              },
                              title: 'Sign Up'),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  )),
                  context: context),
            );
          }),
        ));
  }
}
