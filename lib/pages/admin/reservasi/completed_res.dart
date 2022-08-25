import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/widgets/admin/list_reserve_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_reservation_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class ReservasiCompleted extends StatefulWidget {
  const ReservasiCompleted({Key? key}) : super(key: key);
  @override
  State<ReservasiCompleted> createState() => _CompletedState();
}

class _CompletedState extends State<ReservasiCompleted> {
  _handleBack() => Navigator.of(context).pop();

  final GetReservation _reserveData = GetReservation();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdminWithSearch(
            backButton: _handleBack,
            title: 'Completed',
            onPressed: () {
              showSearch(context: context, delegate: SearchCompleted());
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<Reserve>>(
            future: _reserveData.getAllReserve(statusReserve: 'Completed'),
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
                    _reserveData.getAllReserve(statusReserve: 'Completed');
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return listCardReserve(
                            completed: () {},
                            cenceled: () {},
                            name: data[index].name,
                            phone: data[index].phone,
                            type: data[index].type,
                            time: data[index].time,
                            date: data[index].date,
                            pax: data[index].pax);
                      }));
            }));
  }
}
