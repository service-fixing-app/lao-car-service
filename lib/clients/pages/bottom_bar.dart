import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:service_fixing/clients/pages/home_page.dart';
import 'package:service_fixing/clients/pages/account_setting.dart';

import 'map.dart';
import 'map_test.dart';

class BottomBar extends StatefulWidget {
  // final Map<String, dynamic> userData;

  // const BottomBar({Key? key, required this.userData}) : super(key: key);
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: <Widget>[
          const HomePage(),
          const ColoredBox(color: Colors.redAccent),
          const ColoredBox(color: Colors.redAccent),
          const ColoredBox(color: Colors.redAccent),
          // MapsPage(),
          // const AccountSetting(),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: RollingBottomBar(
        controller: _controller,
        flat: true,
        useActiveColorByDefault: false,
        color: Colors.white,
        items: const [
          RollingBottomBarItem(Icons.home,
              label: 'ໜ້າຫັຼກ', activeColor: Colors.redAccent),
          RollingBottomBarItem(Icons.chat,
              label: 'Page 2', activeColor: Colors.blueAccent),
          RollingBottomBarItem(Icons.notifications,
              label: 'Page 3', activeColor: Colors.yellowAccent),
          RollingBottomBarItem(Icons.person,
              label: 'account', activeColor: Colors.orangeAccent),
        ],
        enableIconRotation: true,
        onTap: (index) {
          _controller.animateToPage(
            index,
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
