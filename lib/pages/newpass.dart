import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import '../widgets/newpassui.dart';

class NewpassPage extends StatefulWidget {
  const NewpassPage({Key? key}) : super(key: key);

  @override
  State<NewpassPage> createState() => _NewpassPageState();
}

class _NewpassPageState extends State<NewpassPage> {
  bool isApicallprocess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#E5E5E5'),
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: const NewpassUI(),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}
