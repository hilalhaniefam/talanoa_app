import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/user/menu_page.dart';
import 'package:talanoa_app/pages/user/user_rent.dart';
import 'package:talanoa_app/pages/user/user_res.dart';
import 'package:talanoa_app/pages/user/sidebar/profile.dart';
import 'package:talanoa_app/pages/user/sidebar/navbar.dart';
import 'package:talanoa_app/widgets/shared/waves.dart';
import 'package:talanoa_app/api_services/launch_url.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String name = 'loading';

  Future<String> getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var userData =
        jsonDecode(sharedPreferences.getString('userData').toString());
    print(userData);
    setState(() {
      name = userData['name'];
    });
    return userData['name'] ?? 'loading';
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
                size: 22,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: IconButton(
              icon: const Icon(
                Icons.account_circle_rounded,
                color: Colors.black,
                size: 22,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const Profile()));
              },
            ),
          ),
        ],
        toolbarHeight: 97,
        backgroundColor: HexColor('#B9C5B2'),
        title: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Image.asset('assets/images/talanoafont.png'),
              ),
            ),
          ],
        ),
      ),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.only(top: 19),
          color: HexColor('#A7B79F'),
          height: MediaQuery.of(context).size.height,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const Padding(
                padding: EdgeInsets.only(left: 18),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Welcome",
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18),
                child: Text(
                  name,
                  style: const TextStyle(
                    fontFamily: 'Josefin Sans',
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                'assets/images/cafe.png',
                width: 270,
                height: 160,
              ),
            ),
            const SizedBox(
              height: 21,
            ),
            Container(
                margin: const EdgeInsets.only(top: 30, left: 43, right: 40),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 123,
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const UserReservationPage()));
                              },
                              child: const Text(
                                "Reservation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: 19,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          HexColor('F1ECE1')),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          side:
                                              BorderSide(color: Colors.grey)))),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: SizedBox(
                                width: 123,
                                height: 80,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const UserRentPage()));
                                  },
                                  child: const Text(
                                    "Rent Area",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 21,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor('F1ECE1')),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.grey)))),
                                ))),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 123,
                            height: 80,
                            child: ElevatedButton(
                              onPressed: () {
                                launchLocation();
                              },
                              child: const Text(
                                "Location",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Josefin Sans',
                                  fontSize: 21,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          HexColor('F1ECE1')),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(15),
                                          ),
                                          side:
                                              BorderSide(color: Colors.grey)))),
                            )),
                        Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: SizedBox(
                                width: 123,
                                height: 80,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const MenuPage()));
                                  },
                                  child: const Text(
                                    "Menu",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Josefin Sans',
                                      fontSize: 21,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              HexColor('F1ECE1')),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                              side: BorderSide(
                                                  color: Colors.grey)))),
                                ))),
                      ],
                    ),
                  ],
                )),
          ]),
        ),
        Align(alignment: Alignment.bottomCenter, child: waves()),
      ]),
    );
  }
}
