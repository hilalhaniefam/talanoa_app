import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/widgets/sidebar/navbar.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  bool isApicallprocess = false;
  String name = 'loading';
  Future<String> getName() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    Map<String, dynamic> userData =
        jsonDecode(sharedPreferences.getString('userData').toString())
            as Map<String, dynamic>;
    print(userData);
    setState(() {
      name = userData['name']; // hapus profile data
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
                size: 22, // Changing Drawer Icon Size
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
                Navigator.pushNamed(context, '/profile');
              },
            ),
          ),
        ],
        toolbarHeight: 120,
        backgroundColor: HexColor('#A7B79F').withOpacity(0.9),
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
      backgroundColor: HexColor('#A7B79F').withOpacity(0.9),
      body: ProgressHUD(
        child: Form(
          child: UserUI(context, name),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget UserUI(BuildContext context, name) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "  Welcome",
            style: TextStyle(
              fontFamily: 'Josefin Sans',
              fontSize: 25,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 134,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rentarea');
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
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              side: BorderSide(color: Colors.grey)))),
                )),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: SizedBox(
                    width: 134,
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/rentarea');
                      },
                      child: const Text(
                        "Rent Area",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      side: BorderSide(color: Colors.grey)))),
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
                width: 134,
                height: 80,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/rentarea');
                  },
                  child: const Text(
                    "Location",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Josefin Sans',
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                              side: BorderSide(color: Colors.grey)))),
                )),
            Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                child: SizedBox(
                    width: 134,
                    height: 80,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/rentarea');
                      },
                      child: const Text(
                        "Menu",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Josefin Sans',
                          fontSize: 19,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                      side: BorderSide(color: Colors.grey)))),
                    ))),
          ],
        ),
        const SizedBox(height: 85),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 110,
          decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  'assets/images/Vector.png',
                )),
          ),
        )
      ],
    ),
  );
}
