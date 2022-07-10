import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../widgets/codeverifui.dart';

class CodeVerifPage extends StatefulWidget {
  final String email;
  final int user_id;
  const CodeVerifPage(this.email, this.user_id, {Key? key}) : super(key: key);
  @override
  State<CodeVerifPage> createState() => _CodeVerifPageState();
}

class _CodeVerifPageState extends State<CodeVerifPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: CodeverifUI(widget.email, widget.user_id),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}
