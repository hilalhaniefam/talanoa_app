import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/api_delete.dart';
import 'package:talanoa_app/api_services/api_getdata.dart';
import 'package:talanoa_app/api_services/reservation_model.dart';
import 'package:talanoa_app/widgets/admin/list_reserve_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_reservation_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class ReservasiCanceled extends StatefulWidget {
  const ReservasiCanceled({Key? key}) : super(key: key);
  @override
  State<ReservasiCanceled> createState() => _CanceledState();
}

class _CanceledState extends State<ReservasiCanceled> {
  _handleBack() => Navigator.of(context).pop();
  final GetReservation _reserveData = GetReservation();
  final ReserveDelete _delete = ReserveDelete();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdminWithSearch(
            backButton: _handleBack,
            title: 'Canceled',
            onPressed: () {
              showSearch(context: context, delegate: SearchCanceled());
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<Reserve>>(
            future: _reserveData.getAllReserve(statusReserve: 'Canceled'),
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
              return RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      _reserveData.getAllReserve(statusReserve: 'Canceled');
                    });
                  },
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return resDeletableCard(
                            delete: () async {
                              _delete.reservationDelete(
                                  transactionId: data[index].transactionId,
                                  context: context);
                              setState(() {
                                _reserveData.getAllReserve(
                                    statusReserve: 'Canceled');
                              });
                            },
                            name: data[index].name,
                            phone: data[index].phone,
                            type: data[index].type,
                            time: data[index].time,
                            date: data[index].date,
                            pax: data[index].pax,
                            request: data[index].request);
                      }));
            }));
  }
}
