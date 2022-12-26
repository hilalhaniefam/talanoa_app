import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/rent_area/canceled_rent.dart';
import 'package:talanoa_app/pages/admin/rent_area/completed_rent.dart';
import 'package:talanoa_app/pages/admin/rent_area/ongoing_rent.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/button_admin.dart';

class RentArea extends StatefulWidget {
  const RentArea({Key? key}) : super(key: key);

  @override
  State<RentArea> createState() => _RentareaState();
}

class _RentareaState extends State<RentArea> {
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAdmin(backButton: _handleBack, title: 'Rent Area Data'),
      backgroundColor: HexColor('A7B79F'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttonAdmin(
              title: 'Ongoing', page: const RentOngoing(), context: context),
          const SizedBox(
            height: 21,
          ),
          buttonAdmin(
              title: 'Completed',
              page: const Rentareacompleted(),
              context: context),
          const SizedBox(
            height: 21,
          ),
          buttonAdmin(
              title: 'Canceled',
              page: const Rentareacanceled(),
              context: context),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
