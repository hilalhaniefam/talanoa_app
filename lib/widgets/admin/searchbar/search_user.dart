import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_getdata.dart';
import 'package:talanoa_app/api_services/user_model.dart';
import 'package:talanoa_app/widgets/admin/list_user_data.dart';

class SearchUser extends SearchDelegate {
  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: HexColor('A7B79F'),
      appBarTheme: AppBarTheme(
        color: HexColor('#B9C5B2'), // affects AppBar's background color
        toolbarTextStyle: const TextTheme(
                headline6: TextStyle(
                    // headline 6 affects the query text
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold))
            .bodyText2,
        titleTextStyle: const TextTheme(
                headline6: TextStyle(
                    // headline 6 affects the query text
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold))
            .headline6,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
            color: Colors.black,
            onPressed: () {
              if (query.isEmpty) {
                close(context, null);
              } else {
                query = '';
              }
            },
            icon: const Icon(Icons.clear))
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        color: Colors.black,
        onPressed: () {
          close(context, null);
          // print(search);
        },
        icon: const Icon(Icons.arrow_back),
      );

  final GetUser _userList = GetUser();
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: HexColor('A7B79F'),
      child: FutureBuilder<List<User>>(
        future: _userList.getAllUsers(query: query),
        builder: (context, AsyncSnapshot snapshot) {
          var data = snapshot.data;
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data.isEmpty) {
              return const Center(child: Text('Data Not Found'));
            }
          }
          return RefreshIndicator(
            onRefresh: () async {
              _userList.getAllUsers();
            },
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return listCardUsers(
                      name: data[index].name,
                      phone: data[index].phone,
                      email: data[index].email);
                }),
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
