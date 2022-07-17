import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/admin/userdata_page.dart';

// import '../widgets/adminui.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminState();
}

class _AdminState extends State<AdminPage> {
  bool isApicallprocess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('C6D0C1'),
      body: ProgressHUD(
        child: Form(
          child: AdminUI(context),
        ),
        inAsyncCall: isApicallprocess,
        key: UniqueKey(),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget AdminUI(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.30,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/Ellipse2.png'))),
          // gradient: LinearGradient(
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          //   colors: [
          //     HexColor('A7B79F'),
          //     HexColor('A7B79F'),
          //   ],
          // ),
          // borderRadius: const BorderRadius.only(
          //     bottomLeft: Radius.circular(100),
          //     bottomRight: Radius.circular(100))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '  Halo, Admin',
                  style: TextStyle(
                      fontFamily: 'Sansation_Bold',
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                      color: Colors.black),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '  Selamat Datang!',
                  style: TextStyle(
                      fontFamily: 'Sansation_Bold',
                      fontWeight: FontWeight.bold,
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
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: HexColor('#F1ECE1'), shadowColor: Colors.grey)),
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
                    Navigator.pushNamed(context, '/reservasidata');
                  },
                  child: const Text(
                    "Reservasi Data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor('#F1ECE1'))),
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
                    Navigator.pushNamed(context, '/rentarea');
                  },
                  child: const Text(
                    "Rent Area Data",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Sansation',
                      fontSize: 25,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style:
                      ElevatedButton.styleFrom(primary: HexColor('#F1ECE1'))),
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
                    fontFamily: 'Sansation',
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                )))
      ],
    ),
  );
}

void signOut() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.remove('userData');
}
