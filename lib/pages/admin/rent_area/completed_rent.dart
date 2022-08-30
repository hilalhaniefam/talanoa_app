import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/delete_api.dart';
import 'package:talanoa_app/api_services/getdata_api.dart';
import 'package:talanoa_app/api_services/rentarea_model.dart';
import 'package:talanoa_app/widgets/admin/list_rentarea_data.dart';
import 'package:talanoa_app/widgets/admin/searchbar/search_rentarea_data.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';

class Rentareacompleted extends StatefulWidget {
  const Rentareacompleted({Key? key}) : super(key: key);
  @override
  State<Rentareacompleted> createState() => _CompletedState();
}

class _CompletedState extends State<Rentareacompleted> {
  _handleBack() => Navigator.of(context).pop();
  final GetRent _rentData = GetRent();
  final RentAreaDelete _delete = RentAreaDelete();

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
        body: FutureBuilder<List<RentData>>(
            future: _rentData.getAllRent(statusRent: 'Completed'),
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
                      _rentData.getAllRent(statusRent: 'Completed');
                    });
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
