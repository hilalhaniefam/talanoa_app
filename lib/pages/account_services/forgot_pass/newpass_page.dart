import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/account_services/forgot_pass/updatepass_success.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:talanoa_app/api_services/ipurl.dart';

class NewpassPage extends StatefulWidget {
  final String email;
  const NewpassPage(this.email, {Key? key}) : super(key: key);

  @override
  State<NewpassPage> createState() => _NewpassPageState();
}

class _NewpassPageState extends State<NewpassPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  Map formValue = {
    'password': TextEditingController(),
    'confPassword': TextEditingController(),
  };
  bool validatePass(String pass) {
    RegExp passvalid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])");
    if (passvalid.hasMatch(pass)) {
      return true;
    } else {
      return false;
    }
  }

  void updatePass(String password, String confPass, String email) async {
    try {
      Response response = await put(Uri.parse('$ipurl/update-password'), body: {
        'password': password,
        'confPassword': confPass,
        'email': email
      });
      print('Update pass:');
      print(response.body);
      print(response.statusCode);
      var data = jsonDecode(response.body.toString());
      var newData = jsonDecode(jsonEncode(data['payload']));
      if (response.statusCode == 200) {
        print('USER:');
        print(newData);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Passupdate()));
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
        body: SingleChildScrollView(
            child: Form(
                key: formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 110, left: 30, right: 20),
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
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'NEW PASSWORD',
                                style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                    color: Colors.black),
                              ),
                            ),
                            Center(
                                child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, bottom: 10),
                              child: Text(
                                'Your identity has been verified! Set your new password',
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 18,
                                  color: HexColor('#3D3D3D'),
                                ),
                              ),
                            )),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 16.17,
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your password';
                                  } else {
                                    bool result = validatePass(value);
                                    if (result) {
                                      return null;
                                    } else {
                                      return 'Password must contain uppercase, lowercase and numbers';
                                    }
                                  }
                                },
                                controller: formValue['password'],
                                obscureText: true,
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
                              ),
                              child: TextFormField(
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please re-enter your password';
                                  }
                                  return null;
                                },
                                controller: formValue['confPassword'],
                                obscureText: true,
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
                              height: 50,
                            ),
                            submitButton(
                                onTap: () {
                                  formKey.currentState!.validate();
                                  updatePass(
                                      formValue['password'].text,
                                      formValue['confPassword'].text,
                                      widget.email);
                                },
                                title: 'Done'),
                          ],
                        ),
                      )
                    ]))));
  }
}
