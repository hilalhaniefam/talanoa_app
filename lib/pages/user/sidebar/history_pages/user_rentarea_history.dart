import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_getdata.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/widgets/user/list_history.dart';

class UserRentAreaHistory extends StatefulWidget {
  const UserRentAreaHistory({Key? key}) : super(key: key);

  @override
  State<UserRentAreaHistory> createState() => _UserRentAreaHistoryState();
}

class _UserRentAreaHistoryState extends State<UserRentAreaHistory> {
  final GetRent _rentArea = GetRent();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('#A7B79F'),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          decoration: BoxDecoration(color: HexColor('#B9C5B2')),
          child: const Align(
              alignment: Alignment.center,
              child: Text(
                'History',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              )),
        ),
        Expanded(
          child: FutureBuilder<List<RentData>>(
            future: _rentArea.getAllRentByUserId(),
            builder: (context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                );
              } else {
                if (snapshot.data.isEmpty) {
                  return const Center(child: Text('Data Not Found'));
                }
              }
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return rentOngoingCardHistory(
                    name: data[index].name,
                    phone: data[index].phone,
                    type: data[index].type,
                    time: data[index].time,
                    date: data[index].date,
                  );
                },
              );
            },
          ),
        ),
      ]),
    );
  }
}
