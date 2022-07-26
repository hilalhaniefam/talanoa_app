import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/shared/waves.dart';

class FlavouredTea extends StatefulWidget {
  const FlavouredTea({Key? key}) : super(key: key);

  @override
  State<FlavouredTea> createState() => _MenudataState();
}

class _MenudataState extends State<FlavouredTea> {
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: HexColor('#B9C5B2'),
        ),
        backgroundColor: HexColor('A7B79F'),
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(color: HexColor('#B9C5B2')),
              child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Flavoured Tea',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView(),
            ),
            waves2(),
          ],
        ));
  }
}
