import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';

class ReserveUpdate {
  var data = [];
  List<Reserve> results = [];

  Future<List<Reserve>> reservationCompleted(
      {String? transactionId, required BuildContext context}) async {
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

  Future<List<Reserve>> reservationCanceled(
      {String? transactionId, required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await put(Uri.parse('$ipurl/reservetable/canceled'), body: {
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

class RentAreaUpdate {
  var data = [];
  List<RentData> results = [];

  Future<List<RentData>> rentAreaCompleted(
      {String? transactionId, required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await put(Uri.parse('$ipurl/rentarea/completed'), body: {
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

  Future<List<RentData>> rentAreaCanceled(
      {String? transactionId, required BuildContext context}) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    String token = userData['accessToken'];
    var response = await put(Uri.parse('$ipurl/rentarea/canceled'), body: {
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
