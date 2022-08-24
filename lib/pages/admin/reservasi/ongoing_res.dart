import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/admin/list_data_reserve.dart';

class ReservasiOngoing extends StatefulWidget {
  const ReservasiOngoing({Key? key}) : super(key: key);
  @override
  State<ReservasiOngoing> createState() => _OngoingState();
}

class _OngoingState extends State<ReservasiOngoing> {
  _handleBack() => Navigator.of(context).pop();
  bool isApicallprocess = false;
  List<dynamic> reserves = [];

  Future<void> getReserve() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    Response response = await get(Uri.parse('$ipurl/reservetable/get'),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body.toString());
    print(response.body);
    setState(() {
      reserves = data['payload'];
    });
    print(reserves);
  }

  @override
  void initState() {
    super.initState();
    getReserve();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdmin(backButton: _handleBack, title: 'Ongoing'),
        backgroundColor: HexColor('A7B79F'),
        body: RefreshIndicator(
          onRefresh: getReserve,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: reserves.map(
              (resdata) {
                return listCardReserve(
                    name: resdata['name'],
                    phone: resdata['phone'],
                    type: resdata['type'],
                    time: resdata['time'],
                    date: resdata['date'],
                    pax: '${resdata['pax']} person');
              },
            ).toList(),
          ),
        ));
  }
}
