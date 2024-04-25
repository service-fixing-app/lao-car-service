import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:service_fixing/clients/pages/customer/history/history.dart';
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
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children:  [
          const RepairService(),
          const TowingService(),
          CustomerHistory(),
          const AccountSetting(),
        ],
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
      ),
      bottomNavigationBar: BottomBar(
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
        selectedIndex: _currentPage,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentPage = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: const Icon(Icons.car_repair),
            title: const Text('ບໍລິການສ້ອມແປງ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.car_crash),
            title: const Text('ບໍລິການສ້ອມແປງ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text('ປະຫັວດ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('ບັນຊີຂອງທ່ານ'),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }
}
