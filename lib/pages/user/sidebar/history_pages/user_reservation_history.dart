import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/widgets/admin/list_reserve_data.dart';

class UserReservationHistory extends StatefulWidget {
  const UserReservationHistory({Key? key}) : super(key: key);

  @override
  State<UserReservationHistory> createState() => _UserReservationHistoryState();
}

class _UserReservationHistoryState extends State<UserReservationHistory> {
  final GetReservation _reservation = GetReservation();
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
            child: FutureBuilder<List<Reserve>>(
          future: _reservation.getAllReserveByUserId(),
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
                _reservation.getAllReserveByUserId();
              },
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return listCardReserveHistory(
                    name: data[index].name,
                    phone: data[index].phone,
                    type: data[index].type,
                    time: data[index].time,
                    date: data[index].date,
                    pax: data[index].pax,
                  );
                },
              ),
            );
          },
        )),
      ]),
    );
  }
}
