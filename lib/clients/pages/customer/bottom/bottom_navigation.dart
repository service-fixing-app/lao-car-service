import 'package:flutter/material.dart';
import 'package:service_fixing/clients/pages/customer/history/customer_history.dart';
import 'package:service_fixing/clients/pages/customer/home/repair_service.dart';
import 'package:service_fixing/clients/pages/customer/home/towing_service.dart';
import 'package:service_fixing/clients/pages/customer/settings/account_setting.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentPage = 0;
  final List<Widget> _pages = [
    const RepairService(),
    const TowingService(),
    CustomerHistory(),
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
            label: 'ຮ້ານສ້ອມແປງ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/tow-truck.png',
              width: 25,
              height: 25,
              color: _currentPage == 1 ? Colors.blue : Colors.grey,
            ),
            label: 'ຮ້ານແກ່ລົດ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/chat.png',
              width: 25,
              height: 25,
              color: _currentPage == 2 ? Colors.blue : Colors.grey,
            ),
            label: 'ຂໍ້ຄວາມ',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/user.png',
              width: 25,
              height: 25,
              color: _currentPage == 3 ? Colors.blue : Colors.grey,
            ),
            label: 'ຂອງຂ້ອຍ',
          ),
        ],
      ),
    );
  }
}
