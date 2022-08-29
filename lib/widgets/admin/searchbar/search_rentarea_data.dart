import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/widgets/admin/list_rentarea_data.dart';

class SearchOngoing extends SearchDelegate {
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

  final GetRent _rentData = GetRent();
  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: HexColor('A7B79F'),
        child: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(query: query, statusRent: 'Ongoing'),
            builder: (context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              return RefreshIndicator(
                  onRefresh: () async {
                    _rentData.getAllRent(query: query, statusRent: 'Ongoing');
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return rentOngoingCard(
                          name: data[index].name,
                          phone: data[index].phone,
                          type: data[index].type,
                          time: data[index].time,
                          date: data[index].date,
                          canceled: () {},
                          completed: () {},
                        );
                      }));
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class SearchCompleted extends SearchDelegate {
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

  final GetRent _rentData = GetRent();
  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: HexColor('A7B79F'),
        child: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(query: query, statusRent: 'Completed'),
            builder: (context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              return RefreshIndicator(
                  onRefresh: () async {
                    _rentData.getAllRent(query: query, statusRent: 'Completed');
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return rentDeletableCard(
                          name: data[index].name,
                          phone: data[index].phone,
                          type: data[index].type,
                          time: data[index].time,
                          date: data[index].date,
                          delete: () {},
                        );
                      }));
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}

class SearchCanceled extends SearchDelegate {
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

  final GetRent _rentData = GetRent();
  @override
  Widget buildResults(BuildContext context) {
    return Container(
        color: HexColor('A7B79F'),
        child: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(query: query, statusRent: 'Canceled'),
            builder: (context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              }
              return RefreshIndicator(
                  onRefresh: () async {
                    _rentData.getAllRent(query: query, statusRent: 'Completed');
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return rentDeletableCard(
                          name: data[index].name,
                          phone: data[index].phone,
                          type: data[index].type,
                          time: data[index].time,
                          date: data[index].date,
                          delete: () {},
                        );
                      }));
            }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
