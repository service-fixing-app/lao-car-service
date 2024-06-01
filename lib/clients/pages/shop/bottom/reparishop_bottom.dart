import 'package:flutter/material.dart';
import 'package:service_fixing/clients/pages/shop/home/shop_homepage.dart';
import 'package:service_fixing/clients/pages/shop/message/repairshop_message.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/account_setting.dart';

class RepairshopBottom extends StatefulWidget {
  const RepairshopBottom({super.key});

  @override
  State<RepairshopBottom> createState() => _RepairshopBottomState();
}

class _RepairshopBottomState extends State<RepairshopBottom> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const ShopHomePage(),
    RepairShopMessage(),
    const AccountSetting(),
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
              'assets/images/car.png',
              width: 25,
              height: 25,
              color: _currentPage == 0 ? Colors.blue : Colors.grey,
            ),
            label: 'ຮ້ານສ້ອມແປງລົດ',
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
