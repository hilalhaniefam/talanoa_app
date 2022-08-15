import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/launch_url.dart';

class Helpcenter extends StatefulWidget {
  const Helpcenter({Key? key}) : super(key: key);

  @override
  State<Helpcenter> createState() => _AboutusState();
}

class _AboutusState extends State<Helpcenter> {
  bool isApicallprocess = false;
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
      backgroundColor: HexColor('#A7B79F'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: HexColor('#B9C5B2')),
            child: const Align(
                alignment: Alignment.center,
                child: Text(
                  'Help Center',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 52, top: 60),
            child: SizedBox(
              width: 275,
              height: 64,
              child: ElevatedButton(
                onPressed: () {
                  launchWhatsapp();
                },
                child: const Text(
                  "Talanoa App Issue",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(HexColor('F1ECE1')),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            side: BorderSide(color: Colors.grey)))),
              ),
            ),
          )
        ],
      ),
    );
  }
}
