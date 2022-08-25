import 'dart:convert';

import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';

class ReserveCompleted {
  var data = [];
  List<Reserve> results = [];

  Future<List<Reserve>> reservationCompleted({String? transactionId}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await put(Uri.parse('$ipurl/reservetable/completed'), body: {
      'transactionId': transactionId,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload'];
        print(data);
        results = data.map((data) => Reserve.fromJson(data)).toList();
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}
