import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/reservasi/ongoing_res.dart';

class Reservasidata extends StatefulWidget {
  const Reservasidata({Key? key}) : super(key: key);

  @override
  State<Reservasidata> createState() => _ReservasidataState();
}

class _ReservasidataState extends State<Reservasidata> {
  _handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 110,
        leading: IconButton(
          onPressed: _handleBack,
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
        title: Title(
            color: Colors.black,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 32, top: 55),
                child: Text(
                  'Reservation Data',
                  style: TextStyle(
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(5, 5),
                            blurRadius: 15),
                      ],
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w600,
                      fontSize: 28,
                      color: Colors.black),
                ),
              ),
            )),
        elevation: 0,
        backgroundColor: HexColor('#B9C5B2'),
      ),
      backgroundColor: HexColor('A7B79F'),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 220,
              height: 115,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ReservasiOngoing()));
                  },
                  child: const Text(
                    "Ongoing",
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: HexColor('#F1ECE1'), shadowColor: Colors.grey)),
            )),
        const SizedBox(
          height: 21,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 220,
              height: 115,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reservasi/completed');
                  },
                  child: const Text(
                    "Completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor('#F1ECE1'))),
            )),
        const SizedBox(
          height: 21,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 220,
              height: 115,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/reservasi/cenceled');
                  },
                  child: const Text(
                    "Cenceled",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor('#F1ECE1'))),
            )),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}
