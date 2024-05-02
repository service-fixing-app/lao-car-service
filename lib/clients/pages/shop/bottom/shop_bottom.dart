import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:service_fixing/clients/pages/shop/history/history.dart';
import 'package:service_fixing/clients/pages/shop/home/shop_homepage.dart';
import 'package:service_fixing/clients/pages/shop/settings/account_setting.dart';

class ShopBottomBar extends StatefulWidget {
  const ShopBottomBar({Key? key}) : super(key: key);

  @override
  State<ShopBottomBar> createState() => _ShopBottomBarState();
}

class _ShopBottomBarState extends State<ShopBottomBar> {
  int _currentPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const ShopHomePage(),
          HistoryPage(),
          // const CustomerNotifications(),
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
            title: const Text('ສ້ອມແປງ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.chat),
            title: const Text('ຂໍ້ຄວາມ'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          // BottomBarItem(
          //   icon: const Icon(Icons.notifications_active),
          //   title: const Text('Notications'),
          //   activeColor: Colors.blue,

          //   activeTitleColor: Colors.blue.shade600,
          // ),
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
