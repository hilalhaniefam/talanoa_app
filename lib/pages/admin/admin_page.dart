import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/menu_data/menudata_page.dart';
import 'package:talanoa_app/pages/admin/rentarea_page.dart';
import 'package:talanoa_app/pages/admin/reservasi_page.dart';
import 'package:talanoa_app/pages/admin/userdata_page.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminState();
}

class _AdminState extends State<AdminPage> {
  void signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('C6D0C1'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Ellipse2.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 19),
                      child: Text(
                        'Halo, Admin',
                        style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: Colors.black),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 19),
                      child: Text(
                        'Selamat Datang!',
                        style: TextStyle(
                            fontFamily: 'Josefin Sans',
                            fontWeight: FontWeight.w600,
                            fontSize: 35,
                            color: Colors.black),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 19,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 192,
                height: 89.86,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Reservasidata()));
                    },
                    child: const Text(
                      'Reservation Data',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 19,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 192,
                height: 89.86,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RentArea()));
                    },
                    child: const Text(
                      "Rent Area Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 19,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 192,
                height: 89.86,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Userdata()));
                    },
                    child: const Text(
                      "User Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 19,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 192,
                height: 89.86,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Menudata()));
                    },
                    child: const Text(
                      "Menu Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefin Sans',
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 50,
          ),
          Align(
              alignment: Alignment.center,
              child: TextButton.icon(
                  icon: Image.asset(
                    'assets/images/signout.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    signOut();
                    Navigator.pushNamed(context, '/');
                  },
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Josefin Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 23,
                    ),
                  )))
        ],
      ),
    );
  }
}
