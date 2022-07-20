import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/carousel/carousel_reservation.dart';

class UserRentPage extends StatefulWidget {
  const UserRentPage({Key? key}) : super(key: key);

  @override
  State<UserRentPage> createState() => _UserReservationPageState();
}

class _UserReservationPageState extends State<UserRentPage> {
  _handleBack() => Navigator.of(context).pop();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Map formValue = {'type': '', 'pax': ''};

  final List<String> imgListAssets = [
    'assets/images/indoor_res_75k.png',
    'assets/images/indoor_res_100k.png',
  ];

  Color setTypeButtonColor(type) {
    if (formValue['type'] == type) return Colors.white;
    return Colors.transparent;
  }

  Color setPaxButtonColor(pax) {
    if (formValue['pax'] == pax) return Colors.white;
    return Colors.transparent;
  }

  void chooseType(type) {
    print(type);
    setState(() {
      formValue = {...formValue, 'type': type};
    });
  }

  void choosePax(pax) {
    print(pax);
    setState(() {
      formValue = {...formValue, 'pax': pax};
    });
  }

  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime =
        await showTimePicker(context: context, initialTime: selectedTime);
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  String formatDate(DateTime date) {
    String day = date.day.toString();
    if (day.length < 2) day = '0' + day;

    String month = date.month.toString();
    if (month.length < 2) month = '0' + month;

    String year = date.year.toString();
    return "$day/$month/$year";
  }

  String formatTime(TimeOfDay time) {
    String hour = time.hour.toString();
    if (hour.length < 2) hour = '0' + hour;

    String minute = time.minute.toString();
    if (minute.length < 2) minute = '0' + minute;
    return "$hour : $minute";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: HexColor('#B9C5B2'),
        ),
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
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 145,
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
                      itemCount: imgListAssets.length,
                      itemBuilder: (context, index, realIndex) {
                        final imgList = imgListAssets[index];
                        return buildImage(imgList, index);
                      },
                    )),
                const SizedBox(
                  height: 10,
                ),
                buildIndicator(imgListAssets),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: [
                      const Padding(
                          padding: EdgeInsets.only(top: 10, left: 47),
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
                                  const EdgeInsets.only(top: 13, right: 30),
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
                                              color: Colors.black, width: 1.5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
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
                              padding: const EdgeInsets.only(top: 13, left: 40),
                              child: SizedBox(
                                  width: 130,
                                  height: 45,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              setTypeButtonColor('Outdoor')),
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
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
                      Padding(
                          padding: const EdgeInsets.only(top: 13, right: 200),
                          child: SizedBox(
                              width: 130,
                              height: 45,
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      setTypeButtonColor('Whole Area')),
                                  side: MaterialStateProperty.all(
                                      const BorderSide(
                                          color: Colors.black, width: 1.5)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
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
                              padding:
                                  const EdgeInsets.only(top: 13, right: 30),
                              child: SizedBox(
                                  width: 130,
                                  height: 45,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
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
                              padding: const EdgeInsets.only(top: 13, left: 40),
                              child: SizedBox(
                                  width: 130,
                                  height: 45,
                                  child: OutlinedButton(
                                    style: ButtonStyle(
                                      side: MaterialStateProperty.all(
                                          const BorderSide(
                                              color: Colors.black, width: 1.5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
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
                          padding: EdgeInsets.only(top: 16, left: 47),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Rental Time',
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
                                  const EdgeInsets.only(top: 13, right: 200),
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
                                              color: Colors.black, width: 1.5)),
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0))),
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
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 52),
                        child: SizedBox(
                          width: 194,
                          height: 44,
                          child: FormHelper.submitButton(
                            "Book",
                            () {},
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
              ]))
        ]));
  }
}
