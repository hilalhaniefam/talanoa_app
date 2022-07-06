import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
// import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/loginui.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: const LoginUI(),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}
