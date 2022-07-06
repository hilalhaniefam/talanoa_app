import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../widgets/resetpassui.dart';

class ResetpassPage extends StatefulWidget {
  const ResetpassPage({Key? key}) : super(key: key);

  @override
  State<ResetpassPage> createState() => _ResetpassPageState();
}

class _ResetpassPageState extends State<ResetpassPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: const ResetpassUI(),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}
