import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
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
            height: 290,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/Ellipse2.png'),
                    fit: BoxFit.fill)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Halo, Admin',
                    style: TextStyle(
                        fontFamily: 'Josefins Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.black),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '  Selamat Datang!',
                    style: TextStyle(
                        fontFamily: 'Josefins Sans',
                        fontWeight: FontWeight.w500,
                        fontSize: 35,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 220,
                height: 115,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Userdata()));
                    },
                    child: const Text(
                      "User Data",
                      style: TextStyle(
                        fontFamily: 'Josefins Sans',
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 21,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 220,
                height: 115,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const Reservasidata()));
                    },
                    child: const Text(
                      "Reservasi Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefins Sans',
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: HexColor('#F1ECE1'),
                        shadowColor: Colors.black)),
              )),
          const SizedBox(
            height: 21,
          ),
          Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 220,
                height: 115,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RentArea()));
                    },
                    child: const Text(
                      "Rent Area Data",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Josefins Sans',
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
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
