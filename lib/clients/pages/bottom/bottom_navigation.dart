import 'package:flutter/material.dart';
import 'package:bottom_bar/bottom_bar.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/home_page.dart';
import 'package:service_fixing/clients/pages/menu/customer/account_setting.dart';

import '../../controllers/login/auth_controller.dart';

class CustomBottomBar extends StatefulWidget {
  const CustomBottomBar({Key? key}) : super(key: key);

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  int _currentPage = 0;
  final _pageController = PageController();

  // @override
  // void initState() {
  //   super.initState();
  //   Get.put(AuthController()); // Initialize AuthController
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const HomePage(),
          Container(color: Colors.grey.shade200),
          Container(color: Colors.grey.shade200),
          AccountSetting(),
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
            title: const Text('Home'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.history),
            title: const Text('History'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.notifications_active),
            title: const Text('Notications'),
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
          BottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text('Account'),
            backgroundColorOpacity: 0.1,
            activeColor: Colors.blue,
            activeTitleColor: Colors.blue.shade600,
          ),
        ],
      ),
    );
  }
}
