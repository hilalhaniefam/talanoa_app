import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class ReserveDelete {
  var data = [];
  List<Reserve> results = [];

  Future<List<Reserve>> reservationDelete(
      {String? transactionId, required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await delete(Uri.parse('$ipurl/reservetable/delete'), body: {
      'transactionId': transactionId,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // List<dynamic> data = responseBody['payload'];
        print('INI RESPONSEBODY');
        print(response.body);
        // results = data.map((data) => Reserve.fromJson(data)).toList();
        print('SUKSES');
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['status'].toString()));
      } else {
        print('API error!');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}

class RentAreaDelete {
  var data = [];
  List<Reserve> results = [];

  Future<List<Reserve>> rentDelete(
      {String? transactionId, required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await delete(Uri.parse('$ipurl/rentarea/delete'), body: {
      'transactionId': transactionId,
    }, headers: {
      'Authorization': 'Bearer $token'
    });
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // List<dynamic> data = responseBody['payload'];
        print('INI RESPONSEBODY');
        print(response.body);
        // results = data.map((data) => Reserve.fromJson(data)).toList();
        print('SUKSES');
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message'].toString()));
      } else {
        print('API error!');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}
