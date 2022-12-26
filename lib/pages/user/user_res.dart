import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:talanoa_app/widgets/user/carousel_reservation.dart';
import 'package:talanoa_app/widgets/user/reserve_helper.dart';

class UserReservationPage extends StatefulWidget {
  const UserReservationPage({Key? key}) : super(key: key);

  @override
  State<UserReservationPage> createState() => _UserReservationPageState();
}

class _UserReservationPageState extends State<UserReservationPage> {
  _handleBack() => Navigator.of(context).pop();
  int _itemCount = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final List<String> resSliderAssets = [
    'assets/images/indoor_res_75k.png',
    'assets/images/indoor_res_100k.png',
  ];

  @override
  void initState() {
    selectedTime = firstTime;
    super.initState();
  }

  void chooseType(type) {
    setState(() {
      formValue = {...formValue, 'type': type};
    });
  }

  void choosePax(pax) {
    setState(() {
      formValue = {...formValue, 'pax': pax};
    });
  }

  DateTime selectedDate = DateTime.now().add(const Duration(days: 1));

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().add(const Duration(days: 1)),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  TimeOfDay firstTime = const TimeOfDay(hour: 14, minute: 00);
  TimeOfDay endTime = const TimeOfDay(hour: 22, minute: 00);
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime!.hour < firstTime.hour || pickedTime.hour > endTime.hour) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
          'Sorry, ${formatTime(pickedTime)} is outside operational hours'));
      setState(() {
        selectedTime = firstTime;
      });
    } else {
      setState(() {
        selectedTime = pickedTime;
      });
    }
    if (pickedTime.hour == 22 && pickedTime.minute > 00) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
          'Sorry, ${formatTime(pickedTime)} is outside operational hours'));
      setState(() {
        selectedTime = firstTime;
      });
    }
    if (pickedTime.hour == 21 || pickedTime.hour == 22) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
          'Sorry, ${formatTime(pickedTime)} Talanoa Kopi and Space is about to close'));
      setState(() {
        selectedTime = firstTime;
      });
    }
  }

  void addReserve(
      String type, String date, String time, String pax, String request) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, dynamic> userData =
          jsonDecode(sharedPreferences.getString('userData').toString())
              as Map<String, dynamic>;
      String token = userData['accessToken'];
      Response response = await post(Uri.parse('$ipurl/reservetable/add'),
          body: {
            'type': type,
            'date': date,
            'time': time,
            'pax': pax,
            'request': request
          },
          headers: {
            'Authorization': 'Bearer $token'
          });
      print(response.body);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'reservetableData', jsonEncode(data['payload']));
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message'].toString()));
        setState(() {
          chooseType('');
          choosePax('');
          _itemCount = 0;
        });
      } else {
        if (data['message'].isNotEmpty) {
          throw data['message'];
        } else {
          throw data['error'];
        }
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(e.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(backButton: _handleBack),
        body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            decoration: BoxDecoration(color: HexColor('#B9C5B2')),
            child: const Align(
              alignment: Alignment.center,
              child: Text(
                'Reservation',
                style: TextStyle(
                  fontFamily: 'Josefin Sans',
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - 140,
                decoration: BoxDecoration(color: HexColor('A7B79F')),
                child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 29),
                      child: CarouselSlider.builder(
                        options: CarouselOptions(
                            onPageChanged: ((index, reason) =>
                                setState(() => activeIndex = index)),
                            height: 229,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: false),
                        itemCount: resSliderAssets.length,
                        itemBuilder: (context, index, resIndex) {
                          final imgList = resSliderAssets[index];
                          return buildImage(imgList, index);
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  buildIndicator(resSliderAssets),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              '*If you have placed an order, the admin will contact you via WhatsApp',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            width: 300,
                            child: Text(
                              '*Operational Hours : 14.00 - 22.00',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w700),
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 20, left: 47),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Type',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  setTypeButtonColor('Indoor')),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () {
                                          chooseType('Indoor');
                                        },
                                        child: const Text(
                                          'Indoor',
                                          style: TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 32),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  setTypeButtonColor(
                                                      'Outdoor')),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () {
                                          chooseType('Outdoor');
                                        },
                                        child: const Text(
                                          'Outdoor',
                                          style: TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 13, left: 47),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Date & Time',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () => _selectDate(context),
                                        child: Text(
                                          formatDate(selectedDate),
                                          style: const TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 32),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () => _selectTime(context),
                                        child: Text(
                                          formatTime(selectedTime),
                                          style: const TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 13, left: 47),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Pax',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 5),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  setPaxButtonColor('1-4')),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () {
                                          choosePax('1-4');
                                        },
                                        child: const Text(
                                          '1-4',
                                          style: TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))),
                              Padding(
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 32),
                                  child: SizedBox(
                                      width: 130,
                                      height: 45,
                                      child: OutlinedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  setPaxButtonColor('5-10')),
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: Colors.black,
                                                  width: 1.5)),
                                          shape: MaterialStateProperty.all(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0))),
                                        ),
                                        onPressed: () {
                                          choosePax('5-10');
                                        },
                                        child: const Text(
                                          '5-10',
                                          style: TextStyle(
                                              fontFamily: 'Josefin Sans',
                                              fontSize: 20,
                                              color: Colors.black),
                                        ),
                                      ))),
                            ],
                          ),
                          const Padding(
                              padding: EdgeInsets.only(top: 20, left: 47),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Request More Chair',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: 'Josefin Sans',
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )),
                          Padding(
                              padding: const EdgeInsets.only(top: 10, left: 60),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: SizedBox(
                                  width: 130,
                                  height: 45,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.remove),
                                        onPressed: () =>
                                            setState(() => _itemCount--),
                                      ),
                                      Container(
                                        width: 30,
                                        // padding: const EdgeInsets.all(3.0),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                style: BorderStyle.solid),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.transparent),
                                        child: Center(
                                          child: Text(
                                            _itemCount.toString(),
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 19),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          icon: const Icon(Icons.add),
                                          onPressed: () =>
                                              setState(() => _itemCount++)),
                                    ],
                                  ),
                                ),
                              )),
                          Padding(
                              padding:
                                  const EdgeInsets.only(top: 32, bottom: 10),
                              child: SizedBox(
                                width: 194,
                                height: 44,
                                child: FormHelper.submitButton(
                                  "Book",
                                  () {
                                    addReserve(
                                        formValue['type'],
                                        formatDate(selectedDate),
                                        formatTime(selectedTime),
                                        formValue['pax'],
                                        _itemCount.toString());
                                  },
                                  btnColor: HexColor("#F1ECE1"),
                                  borderColor: Colors.grey,
                                  txtColor: Colors.black,
                                  borderRadius: 10,
                                  fontSize: 20,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ),
                ])),
          )
        ]));
  }
}
