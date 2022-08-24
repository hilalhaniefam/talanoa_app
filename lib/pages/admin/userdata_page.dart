import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_services.dart';
import 'package:talanoa_app/api_services/user_model.dart';
import 'package:talanoa_app/pages/admin/search.dart';
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
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage()));
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<User>>(
          future: _userList.getAllUsers(),
          builder: (context, AsyncSnapshot snapshot) {
            var data = snapshot.data;
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
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
                });
          },
        ));
  }
}
