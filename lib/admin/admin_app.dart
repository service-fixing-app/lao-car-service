import 'package:flutter/material.dart';

import 'admin_dashboard_screen.dart';

class AdminApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Admin-specific routes
      initialRoute: '/admin/dashboard',
      routes: {
        '/admin/dashboard': (context) => const AdminDashboardScreen(),
        // Add more admin routes as needed
      },
    );
  }
}
