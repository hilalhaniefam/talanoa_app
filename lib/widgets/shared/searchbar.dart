// import 'package:flutter/material.dart';

// class MySearchDelegate extends SearchDelegate {
//   List<dynamic> users = [];

//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//             onPressed: () {
//               if (query.isEmpty) {
//                 close(context, null);
//               } else {
//                 query = '';
//               }
//             },
//             icon: const Icon(Icons.clear))
//       ];

//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//         onPressed: () {
//           close(context, null);
//         },
//         icon: const Icon(Icons.arrow_back),
//       );

//   @override
//   Widget buildResults(BuildContext context) {
//     final results = users.where((name) {
//       return name.toLowerCase().contains(query.toLowerCase());
//     });

//     return ListView();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) => Container();
// }
