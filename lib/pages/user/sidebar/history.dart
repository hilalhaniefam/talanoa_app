import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/hex_color.dart';
import 'package:talanoa_app/pages/user/sidebar/history_pages/user_rentarea_history.dart';
import 'package:talanoa_app/pages/user/sidebar/history_pages/user_reservation_history.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  _handleBack() => Navigator.of(context).pop();
  int _selectedIndex = 0;
  final screens = [const UserReservationHistory(), const UserRentAreaHistory()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          leading: IconButton(
            onPressed: _handleBack,
            icon: const Icon(Icons.arrow_back),
            color: Colors.black,
          ),
          elevation: 0,
          backgroundColor: HexColor('#B9C5B2'),
        ),
        backgroundColor: HexColor('#A7B79F'),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            // sets the background color of the `BottomNavigationBar`
            canvasColor: HexColor('#B9C5B2'),
            // sets the active color of the `BottomNavigationBar` if `Brightness` is light
            primaryColor: HexColor('#B9C5B2'),
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(Icons.table_bar_outlined),
                label: 'Reservation',
                backgroundColor: HexColor('#A7B79F'),
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.meeting_room_outlined),
                label: 'Rent Area',
                backgroundColor: HexColor('#A7B79F'),
              )
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            onTap: _onItemTapped,
          ),
        ),
        body: screens[_selectedIndex]);
  }
}
