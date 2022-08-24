import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/admin/list_data_rentarea.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class RentOngoing extends StatefulWidget {
  const RentOngoing({Key? key}) : super(key: key);
  @override
  State<RentOngoing> createState() => _OngoingState();
}

class _OngoingState extends State<RentOngoing> {
  List<dynamic> rentarea = [];

  Future<void> getRentArea() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    Response response = await get(Uri.parse('$ipurl/rentarea/get'),
        headers: {'Authorization': 'Bearer $token'});
    var data = jsonDecode(response.body.toString());
    print(response.body);
    setState(() {
      rentarea = data['payload'];
    });
    print(rentarea);
  }

  @override
  void initState() {
    super.initState();
    getRentArea();
  }

  _handleBack() => Navigator.of(context).pop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdmin(backButton: _handleBack, title: 'Ongoing'),
        backgroundColor: HexColor('A7B79F'),
        body: RefreshIndicator(
          onRefresh: getRentArea,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 20),
            children: rentarea.map(
              (rentdata) {
                return listCardRentArea(
                    name: rentdata['name'],
                    phone: rentdata['phone'],
                    type: rentdata['type'],
                    time: rentdata['time'],
                    date: rentdata['date'],
                    rentalHour: rentdata['rentalHour']);
              },
            ).toList(),
          ),
        ));
  }
}
