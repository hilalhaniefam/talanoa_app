import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/reservasi/ongoing_res.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

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
      appBar: appBarAdmin(backButton: _handleBack, title: 'Reservation Page'),
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
