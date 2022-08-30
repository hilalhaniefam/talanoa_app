import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/api_services/updatedata_api.dart';
import 'package:talanoa_app/widgets/admin/list_rentarea_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_rentarea_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class RentOngoing extends StatefulWidget {
  const RentOngoing({Key? key}) : super(key: key);
  @override
  State<RentOngoing> createState() => _OngoingState();
}

class _OngoingState extends State<RentOngoing> {
  _handleBack() => Navigator.of(context).pop();
  final GetRent _rentData = GetRent();
  final RentAreaUpdate _update = RentAreaUpdate();

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
        body: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(statusRent: 'Ongoing'),
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
                      _rentData.getAllRent(statusRent: 'Ongoing');
                    });
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
                          canceled: () {
                            _update.rentAreaCanceled(
                                transactionId: data[index].transactionId,
                                context: context);
                            setState(() {
                              _rentData.getAllRent(statusRent: 'Ongoing');
                            });
                          },
                          completed: () {
                            _update.rentAreaCompleted(
                                transactionId: data[index].transactionId,
                                context: context);
                            setState(() {
                              _rentData.getAllRent(statusRent: 'Ongoing');
                            });
                          },
                        );
                      }));
            }));
  }
}
