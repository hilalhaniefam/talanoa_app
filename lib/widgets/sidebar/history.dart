import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _AboutusState();
}

class _AboutusState extends State<History> {
  bool isApicallprocess = false;
  _handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
      backgroundColor: HexColor('#A7B79F'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: HexColor('#B9C5B2')),
            child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'History',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
