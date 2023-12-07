import 'package:flutter/material.dart';
import 'package:service_fixing/clients/pages/login_page.dart';

class ClientApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Client-specific routes
      initialRoute: '/client/login',
      routes: {
        '/client/login': (context) => const LoginPage(),
        // Add more client routes as needed
      },
    );
  }
}
