import 'package:shared_preferences/shared_preferences.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
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
