import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/user/sidebar/aboutus.dart';
import 'package:talanoa_app/pages/user/sidebar/helpcenter.dart';
import 'package:talanoa_app/pages/user/sidebar/history.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  void signOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove('userData');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: HexColor('#A7B79F'),
        child: ListView(
          children: [
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 48),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.close,
                    size: 24.0,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Close',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400),
                  ), // <-- Text
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Aboutus()));
                  },
                  icon: Image.asset(
                    'assets/images/Vector!.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'About Us',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400),
                  ), // <-- Text
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const History()));
                  },
                  icon: Image.asset(
                    'assets/images/history.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'History',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400),
                  ), // <-- Text
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Helpcenter()));
                  },
                  icon: Image.asset(
                    'assets/images/ch.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Help Center',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 300),
              child: Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    signOut();
                    Navigator.pushNamed(context, '/');
                  },
                  icon: Image.asset(
                    'assets/images/signout.png',
                    width: 20,
                    height: 20,
                    color: Colors.black,
                  ),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'Josefin Sans',
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
