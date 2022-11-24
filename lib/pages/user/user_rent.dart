import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/api_services/ipurl.dart';
import 'package:talanoa_app/widgets/shared/app_bar.dart';
import 'package:talanoa_app/widgets/user/rent_helper.dart';
import 'package:talanoa_app/widgets/shared/snackbar.dart';
import 'package:talanoa_app/widgets/user/carousel_rentarea.dart';

class UserRentPage extends StatefulWidget {
  const UserRentPage({Key? key}) : super(key: key);

  @override
  State<UserRentPage> createState() => _UserReservationPageState();
}

class _UserReservationPageState extends State<UserRentPage> {
  _handleBack() => Navigator.of(context).pop();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final List<String> rentSliderAssets = [
    'assets/images/indoor&outdoor.png',
    'assets/images/wholearea.png',
  ];

  void chooseType(type) {
    setState(() {
      formValue = {...formValue, 'type': type};
    });
  }

  @override
  void initState() {
    selectedTime = firstTime;
    super.initState();
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
        await showTimePicker(context: context, initialTime: firstTime);
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
    if (pickedTime.hour == 21 && pickedTime.minute >= 30 ||
        pickedTime.hour == 22) {
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackbar(
          'Sorry, ${formatTime(pickedTime)} Talanoa Kopi and Space is about to close'));
      setState(() {
        selectedTime = firstTime;
      });
    }
  }

  void addRent(String type, String date, String time) async {
    try {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      Map<String, dynamic> userData =
          jsonDecode(sharedPreferences.getString('userData').toString())
              as Map<String, dynamic>;
      String token = userData['accessToken'];
      Response response = await post(Uri.parse('$ipurl/rentarea/add'), body: {
        'type': type,
        'date': date,
        'time': time,
      }, headers: {
        'Authorization': 'Bearer $token'
      });
      print(response.body);
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString(
            'rentAreaData', jsonEncode(data['payload']));
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackbar(data['message'].toString()));
        setState(() {
          chooseType('');
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
                'Rent Area',
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
                height: MediaQuery.of(context).size.height,
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
                        itemCount: rentSliderAssets.length,
                        itemBuilder: (context, index, rentIndex) {
                          final imgList = rentSliderAssets[index];
                          return buildImage(imgList, index);
                        },
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  buildIndicator(rentSliderAssets),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(children: [
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
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(top: 13),
                                    child: SizedBox(
                                        width: 130,
                                        height: 45,
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    setTypeButtonColor(
                                                        'Indoor')),
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
                                    padding: const EdgeInsets.only(top: 13),
                                    child: SizedBox(
                                        width: 130,
                                        height: 45,
                                        child: OutlinedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    setTypeButtonColor(
                                                        'Whole Area')),
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
                                            chooseType('Whole Area');
                                          },
                                          child: const Text(
                                            'Whole Area',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Josefin Sans',
                                                fontSize: 18,
                                                color: Colors.black),
                                          ),
                                        ))),
                              ],
                            ),
                            Column(
                              children: [
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: 32, top: 13),
                                    child: Align(
                                      alignment: Alignment.topCenter,
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
                                          )),
                                    )),
                                const Padding(
                                    padding: EdgeInsets.only(left: 32, top: 13),
                                    child: SizedBox(
                                      width: 130,
                                      height: 45,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const Padding(
                            padding: EdgeInsets.only(top: 16, left: 47),
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
                                padding: const EdgeInsets.only(top: 13),
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
                                    const EdgeInsets.only(top: 13, left: 32),
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30, bottom: 15),
                          child: SizedBox(
                            width: 194,
                            height: 44,
                            child: FormHelper.submitButton(
                              "Book",
                              () {
                                addRent(
                                  formValue['type'],
                                  formatDate(selectedDate),
                                  formatTime(selectedTime),
                                );
                              },
                              btnColor: HexColor("#F1ECE1"),
                              borderColor: Colors.grey,
                              txtColor: Colors.black,
                              borderRadius: 10,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ]),
                    ),
                  ),
                ])),
          )
        ]));
  }
}
