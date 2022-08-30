import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/delete_api.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/widgets/admin/list_rentarea_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_rentarea_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class Rentareacanceled extends StatefulWidget {
  const Rentareacanceled({Key? key}) : super(key: key);
  @override
  State<Rentareacanceled> createState() => _CanceledState();
}

class _CanceledState extends State<Rentareacanceled> {
  final GetRent _rentData = GetRent();
  final RentAreaDelete _delete = RentAreaDelete();
  _handleBack() => Navigator.of(context).pop();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarAdminWithSearch(
            backButton: _handleBack,
            title: 'Cenceled',
            onPressed: () {
              showSearch(context: context, delegate: SearchCanceled());
            }),
        backgroundColor: HexColor('A7B79F'),
        body: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(statusRent: 'Canceled'),
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
                    _rentData.getAllRent(statusRent: 'Canceled');
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
                          delete: () {
                            _delete.rentDelete(
                                transactionId: data[index].transactionId,
                                context: context);
                            setState(() {
                              _rentData.getAllRent(statusRent: 'Completed');
                            });
                          },
                        );
                      }));
            }));
  }
}
