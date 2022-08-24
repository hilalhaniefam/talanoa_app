import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:talanoa_app/api_services/user_model.dart';

class GetUser {
  var data = [];
  List<User> results = [];

  Future<List<User>> getAllUsers() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    String token = userData['accessToken'];
    var response = await http.get(Uri.parse('$ipurl/users'),
        headers: {'Authorization': 'Bearer $token'});
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    List<dynamic> data = responseBody['payload'];
    print(data);
    results = data.map((data) => User.fromJson(data)).toList();
    return results;
  }
}
