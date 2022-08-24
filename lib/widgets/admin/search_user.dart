import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_services.dart';
import 'package:talanoa_app/api_services/user_model.dart';

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
          }
          return RefreshIndicator(
            onRefresh: () async {
              _userList.getAllUsers();
            },
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin:
                          const EdgeInsets.only(left: 36, top: 29, right: 78),
                      color: HexColor('F1ECE1'),
                      child: SizedBox(
                        width: 261,
                        height: 111,
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 34, top: 22),
                                child: Text(
                                  data[index].name,
                                  style: const TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 34, top: 6),
                                child: Text(
                                  data[index].phone,
                                  style: const TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 34, top: 6),
                                child: Text(
                                  data[index].email,
                                  style: const TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ));
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
