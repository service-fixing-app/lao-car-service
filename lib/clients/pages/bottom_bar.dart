import 'package:flutter/material.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar.dart';
import 'package:rolling_bottom_bar/rolling_bottom_bar_item.dart';
import 'package:service_fixing/clients/pages/home_page.dart';
import 'package:service_fixing/constants.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

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
        children: const <Widget>[
          HomePage(),
          ColoredBox(color: Colors.redAccent),
          ColoredBox(color: Colors.greenAccent),
          ColoredBox(color: Colors.yellowAccent),
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
              label: 'Page 4', activeColor: Colors.orangeAccent),
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
