import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class NewpassPage extends StatefulWidget {
  const NewpassPage({Key? key}) : super(key: key);

  @override
  State<NewpassPage> createState() => _NewpassPageState();
}

class _NewpassPageState extends State<NewpassPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isEmailValidate = false;
  bool validateTextField(String email) {
    if (email.isEmpty) {
      setState(() {
        isEmailValidate = true;
      });
      return false;
    }
    setState(() {
      isEmailValidate = false;
    });
    return true;
  }

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HexColor('#E5E5E5'),
        body: ProgressHUD(
            inAsyncCall: isApicallprocess,
            key: formKey,
            child: SingleChildScrollView(
                child: Column(
                    key: formKey,
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 130,
                        ),
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
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                            child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
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
                              top: 36, left: 32, right: 32),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(
                                    left: 16, top: 12.17, bottom: 12.12),
                                hintText: 'New Password',
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: Colors.black, width: 2.0)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: Colors.black, width: 2.0),
                                ),
                                errorText: isEmailValidate
                                    ? 'Please enter Password'
                                    : null),
                            style: const TextStyle(
                                fontFamily: 'Josefin Sans', fontSize: 17),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 17, left: 32, right: 32),
                          child: TextFormField(
                            controller: emailController,
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
                                errorText: isEmailValidate
                                    ? 'Please enter Password'
                                    : null),
                            style: const TextStyle(
                                fontFamily: 'Josefin Sans', fontSize: 17),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: FormHelper.submitButton(
                            "Done",
                            () {
                              validateTextField(emailController.text);
                              Navigator.pushNamed(context, '/passupdate');
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
                ]))));
  }
}
