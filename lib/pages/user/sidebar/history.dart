import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/admin/list_reserve_data.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool isApicallprocess = false;
  _handleBack() => Navigator.of(context).pop();
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

  // Future<void> getRentArea() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   var userData =
  //       jsonDecode(sharedPreferences.getString('userData').toString());
  //   String token = userData['accessToken'];
  //   Response response = await get(Uri.parse('$ipurl/rentarea/get'),
  //       headers: {'Authorization': 'Bearer $token'});
  //   var data = jsonDecode(response.body.toString());
  //   print(response.body);
  //   setState(() {
  //     reserves = data['payload'];
  //   });
  //   print(reserves);
  // }

  @override
  void initState() {
    super.initState();
    getReserve();
    // getRentArea();
  }

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
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        Expanded(
            child: ProgressHUD(
                child: Builder(
          builder: (context) => Center(
              child: RefreshIndicator(
            onRefresh: getReserve,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListView(
                children: reserves.map(
                  (resdata) {
                    return listCardReserve(
                        cenceled: () {},
                        completed: () {},
                        name: resdata['name'],
                        phone: resdata['phone'],
                        type: resdata['type'],
                        time: resdata['time'],
                        date: resdata['date'],
                        pax: '${resdata['pax']} person');
                  },
                ).toList(),
              ),
            ),
          )),
        ))),
      ]),
    );
  }
}
