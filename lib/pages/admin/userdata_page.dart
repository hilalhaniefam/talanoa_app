import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_getdata.dart';
import 'package:talanoa_app/api_services/user_model.dart';
import 'package:talanoa_app/widgets/admin/list_user_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_user.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class Userdata extends StatefulWidget {
  const Userdata({Key? key}) : super(key: key);
  @override
  State<Userdata> createState() => _UserdataState();
}

class _UserdataState extends State<Userdata> {
  _handleBack() => Navigator.of(context).pop();

  final GetUser _userList = GetUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdminWithSearch(
            backButton: _handleBack,
            title: 'User Data',
            onPressed: () {
              showSearch(context: context, delegate: SearchUser());
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<User>>(
          future: _userList.getAllUsers(),
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
        ));
  }
}
