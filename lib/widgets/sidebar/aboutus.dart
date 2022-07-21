import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class Aboutus extends StatefulWidget {
  const Aboutus({Key? key}) : super(key: key);

  @override
  State<Aboutus> createState() => _AboutusState();
}

class _AboutusState extends State<Aboutus> {
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
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  'About Us',
                  style: TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 25,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                )),
          ),
          const SizedBox(
            height: 28,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/talanoa.png',
              width: 290,
              height: 180,
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Padding(
            padding: EdgeInsets.only(left: 33, top: 30, right: 34),
            child: Text(
              'Talanoa Kopi and Space merupakan kedai kopi yang dibangun pada 8 oktober 2020. Design dari Talanoa Kopi & Space sendiri menganut gaya industrial namun sejuk karena banyak tanaman yang ada di Talanoa Kopi & Space.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 33, top: 38, right: 34),
            child: Text(
              'Impian kami adalah dapat membuat pelanggan yang pernah ke Talanoa Kopi & Space menjadi kebiasaan untuk berkunjung atau memesan online. Talanoa Kopi & Space.',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontFamily: 'Josefin Sans',
                fontSize: 21,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      ),
    );
  }
}
