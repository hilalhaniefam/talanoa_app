import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../widgets/codeverifui.dart';

class CodeVerifPage extends StatefulWidget {
  const CodeVerifPage({Key? key}) : super(key: key);

  @override
  State<CodeVerifPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<CodeVerifPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: const CodeverifUI(),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}
