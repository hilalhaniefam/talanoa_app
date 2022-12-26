import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/admin/get_image.dart';
import 'package:talanoa_app/widgets/admin/menu_button.dart';
import 'package:talanoa_app/widgets/shared/all_submit_button.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/listmenu_catalogue.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class AddPax extends StatefulWidget {
  const AddPax({Key? key}) : super(key: key);

  @override
  State<AddPax> createState() => _AddPaxState();
}

class _AddPaxState extends State<AddPax> {
  int _itemCount = 10;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String ip = '$ipurl/menu/add';
  Map formValue = {
    'pax': TextEditingController(),
    'description': TextEditingController(),
    'type': ''
  };
  _handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarAdmin(backButton: _handleBack, title: 'Add Pax'),
      backgroundColor: HexColor('A7B79F'),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Current maximum pax :',
                  style: TextStyle(fontSize: 19),
                )),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () => setState(() => _itemCount--),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  child: Text(
                    _itemCount.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 19),
                  ),
                ),
                IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => setState(() => _itemCount++)),
              ],
            ),
            const SizedBox(
              height: 200,
            ),
            submitButton(onTap: () {}, title: 'Update')
          ],
        ),
      ),
    );
  }
}
