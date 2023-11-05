import 'package:flutter/material.dart';
import 'package:service_fixing/views/home_page.dart';
import 'package:service_fixing/views/map.dart';
import 'package:service_fixing/views/login_page.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    home: const MyApp(),
    getPages: [
      GetPage(
        name: '/home',
        page: () => const HomePage(),
        // name: '/map',
        // page: () => MapsPage(),
      ),
    ],
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Services Fixing Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const LoginPage(),
    );
  }
}
