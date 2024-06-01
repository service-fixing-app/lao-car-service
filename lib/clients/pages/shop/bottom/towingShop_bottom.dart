import 'package:flutter/material.dart';
import 'package:service_fixing/clients/pages/shop/message/towingshop_message.dart';
import 'package:service_fixing/clients/pages/shop/home/towingShop_homepage.dart';
import 'package:service_fixing/clients/pages/shop/towingshop_settings/account_setting.dart';

class TowingshopBottomBar extends StatefulWidget {
  const TowingshopBottomBar({Key? key}) : super(key: key);

  @override
  State<TowingshopBottomBar> createState() => _TowingshopBottomBarState();
}

class _TowingshopBottomBarState extends State<TowingshopBottomBar> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const TowingShopHome(),
    TowingShopMessage(),
    const TowingshopSetting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentPage],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentPage,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tow-truck.png',
              width: 25,
              height: 25,
              color: _currentPage == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'ຮ້ານແກ່ລົດ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/chat.png',
              width: 25,
              height: 25,
              color: _currentPage == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'ຂໍ້ຄວາມ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/user.png',
              width: 25,
              height: 25,
              color: _currentPage == 2 ? Colors.blue : Colors.grey,
            ),
            label: 'ຂອງຂ້ອຍ',
          ),
        ],
      ),
    );
  }
}
