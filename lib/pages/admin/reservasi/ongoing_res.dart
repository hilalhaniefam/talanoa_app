import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/api_services/updatedata_api.dart';
import 'package:talanoa_app/widgets/admin/list_reserve_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_reservation_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class ReservasiOngoing extends StatefulWidget {
  const ReservasiOngoing({Key? key}) : super(key: key);
  @override
  State<ReservasiOngoing> createState() => _OngoingState();
}

class _OngoingState extends State<ReservasiOngoing> {
  _handleBack() => Navigator.of(context).pop();

  final GetReservation _reserveData = GetReservation();
  final ReserveUpdate _update = ReserveUpdate();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdminWithSearch(
            backButton: _handleBack,
            title: 'Ongoing',
            onPressed: () {
              showSearch(context: context, delegate: SearchOngoing());
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<Reserve>>(
            future: _reserveData.getAllReserve(statusReserve: 'Ongoing'),
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
                    setState(() {
                      _reserveData.getAllReserve(statusReserve: 'Ongoing');
                    });
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return resOngoingCard(
                            completed: () {
                              _update.reservationCompleted(
                                  transactionId: data[index].transactionId,
                                  context: context);
                              setState(() {
                                _reserveData.getAllReserve(
                                    statusReserve: 'Ongoing');
                              });
                            },
                            canceled: () {
                              _update.reservationCanceled(
                                  transactionId: data[index].transactionId,
                                  context: context);
                              setState(() {
                                _reserveData.getAllReserve(
                                    statusReserve: 'Ongoing');
                              });
                            },
                            name: data[index].name,
                            phone: data[index].phone,
                            type: data[index].type,
                            time: data[index].time,
                            date: data[index].date,
                            pax: '${data[index].pax} person');
                      }));
            }));
  }
}
