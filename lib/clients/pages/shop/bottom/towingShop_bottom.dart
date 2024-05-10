import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:service_fixing/clients/pages/shop/history/history.dart';
import 'package:service_fixing/clients/pages/shop/home/towingShop_homepage.dart';
import 'package:service_fixing/clients/pages/shop/settings/account_setting.dart';

class TowingshopBottomBar extends StatefulWidget {
  const TowingshopBottomBar({Key? key}) : super(key: key);

  @override
  State<TowingshopBottomBar> createState() => _TowingshopBottomBarState();
}

class _TowingshopBottomBarState extends State<TowingshopBottomBar> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const TowingShopHome(),
          HistoryPage(),
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
            icon: const Icon(Icons.home),
            title: const Text('ຮ້ານແກ່ລົດ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.chat),
            title: const Text('ຂໍ້ຄວາມ'),
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
