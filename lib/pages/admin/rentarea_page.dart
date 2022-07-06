import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';

class RentArea extends StatefulWidget {
  const RentArea({Key? key}) : super(key: key);

  @override
  State<RentArea> createState() => _RentareaState();
}

class _RentareaState extends State<RentArea> {
  bool isApicallprocess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('C6D0C1'),
      body: ProgressHUD(
        child: Form(
          child: rentareaUI(context),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget rentareaUI(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                HexColor('B9C5B2'),
                HexColor('B9C5B2'),
              ],
            ),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(
              height: 130,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Data Reservation',
                style: TextStyle(
                    shadows: [
                      Shadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(5, 5),
                          blurRadius: 15),
                    ],
                    fontFamily: 'Sansation_Bold',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: Colors.black),
              ),
            ),
          ]),
        ),
        const SizedBox(
          height: 89,
        ),
        Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 220,
              height: 115,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rentarea/ongoing');
                  },
                  child: const Text(
                    "Ongoing",
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
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
                    Navigator.pushNamed(context, '/rentarea/completed');
                  },
                  child: const Text(
                    "Completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
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
                    Navigator.pushNamed(context, '/rentarea/cenceled');
                  },
                  child: const Text(
                    "Cenceled",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor('#F1ECE1'))),
            )),
        const SizedBox(
          height: 50,
        ),
      ],
    ),
  );
}
