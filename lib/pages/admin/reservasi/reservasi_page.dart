import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/reservasi/cenceled_res.dart';
import 'package:talanoa_app/pages/admin/reservasi/completed_res.dart';
import 'package:talanoa_app/pages/admin/reservasi/ongoing_res.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/button_admin.dart';

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
      appBar: appBarAdmin(backButton: _handleBack, title: 'Reservation Data'),
      backgroundColor: HexColor('A7B79F'),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        buttonAdmin(
            context: context, page: const ReservasiOngoing(), title: 'Ongoing'),
        const SizedBox(
          height: 21,
        ),
        buttonAdmin(
            title: 'Completed',
            page: const ReservasiCompleted(),
            context: context),
        const SizedBox(
          height: 21,
        ),
        buttonAdmin(
            title: 'Cenceled',
            page: const ReservasiCenceled(),
            context: context),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}
