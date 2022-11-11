import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/api_services/user_model.dart';

class GetUser {
  var data = [];
  List<User> results = [];

  Future<List<User>> getAllUsers({String? query}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(Uri.parse('$ipurl/users'),
        headers: {'Authorization': 'Bearer $token'});
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload'];
        print(data);
        results = data.map((data) => User.fromJson(data)).toList();
        if (query != null) {
          results = results
              .where((u) => u.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}

class GetReservation {
  var data = [];
  List<Reserve> results = [];

  Future<List<Reserve>> getAllReserve(
      {String? query, String? statusReserve}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(Uri.parse('$ipurl/reservetable/get'),
        headers: {'Authorization': 'Bearer $token'});
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload'];
        print(data);
        results = data.map((data) => Reserve.fromJson(data)).toList();
        results = results.where((u) => u.status! == statusReserve).toList();
        if (query != null) {
          results = results
              .where((u) => u.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }

  Future<List<Reserve>> getAllReserveByUserId({String? query}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(
        Uri.parse('$ipurl/get-all-reservation')
            .replace(query: userData['userId']),
        headers: {'Authorization': 'Bearer $token'});
    print('INI USER ID');
    print(userData['userId']);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload']['reserveTable'];
        print(data);
        results = data.map((data) => Reserve.fromJson(data)).toList();
        if (query != null) {
          results = results
              .where((u) => u.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}

class GetRent {
  var data = [];
  List<RentData> results = [];

  Future<List<RentData>> getAllRent({String? query, String? statusRent}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(Uri.parse('$ipurl/rentarea/get'),
        headers: {'Authorization': 'Bearer $token'});
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload'];
        print(data);
        results = data.map((data) => RentData.fromJson(data)).toList();
        results = results.where((u) => u.status! == statusRent).toList();
        if (query != null) {
          results = results
              .where((u) => u.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }

  Future<List<RentData>> getAllRentByUserId({String? query}) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(
        Uri.parse('$ipurl/get-all-reservation')
            .replace(query: userData['userId']),
        headers: {'Authorization': 'Bearer $token'});
    print('INI USER ID');
    print(userData['userId']);
    try {
      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['payload']['rentArea'];
        print(data);
        results = data.map((data) => RentData.fromJson(data)).toList();
        if (query != null) {
          results = results
              .where((u) => u.name!.toLowerCase().contains(query.toLowerCase()))
              .toList();
        }
      } else {
        print('API error');
      }
    } on Exception catch (e) {
      print(e);
    }
    return results;
  }
}
