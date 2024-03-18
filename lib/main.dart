import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:service_fixing/clients/controllers/customer/register_controller.dart';
import 'package:service_fixing/clients/controllers/customer/verifieotp_controller.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/pages/login/login.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/login/verify_code.dart';
import 'package:service_fixing/clients/pages/register/customer/customer_form.dart';
import 'package:service_fixing/clients/pages/register/repairshop/repairshop_form.dart';
import 'package:service_fixing/clients/pages/register/repairshop/repairshop_otp.dart';
import 'package:service_fixing/clients/pages/register/repairshop/repairshop_verify.dart';
import 'package:service_fixing/clients/pages/register/towingtruck/towingtruck_form.dart';
import 'package:service_fixing/clients/pages/register/towingtruck/towingtruck_otp.dart';
import 'package:service_fixing/clients/pages/register/towingtruck/towingtruck_verify.dart';
import 'clients/controllers/repairshop/repairshopRegister_controller.dart';
import 'clients/pages/bottom/bottom_navigation.dart';
import 'clients/pages/home_page.dart';
import 'clients/pages/map/map_page.dart';

// void main() {
//   runApp(
//     const MyApp(),
//   );
// }
void main() async {
  Get.put(AuthController());
  Get.put(OtpController());
  Get.put(RepairshopController());
  Get.put(CustomerRegisterController());
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDii6Ju19E7fgESLccP7yYahpuKo4NGv_U",
        appId: "1:883799409029:android:c72720f769b2bc810584ec",
        messagingSenderId: "883799409029",
        projectId: "phone-otp-verify-cd321",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Services Fixing Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/HomePage',
          page: () => HomePage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/BottomBar',
          page: () => CustomBottomBar(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/VerifyCode',
          page: () => VerifyCode(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/customerForm',
          page: () => const CustomerForm(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/repairshopForm',
          page: () => const RepairshopForm(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/repairshopVerify',
          page: () => const RepairshopVerify(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/repairshop_otp',
          page: () => const RepairshopOtp(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/towingtruckForm',
          page: () => const TowingtruckForm(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/towingtruckVerify',
          page: () => const TowingtruckVerify(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/towingtruck_otp',
          page: () => const TowingtruckOtp(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/Map',
          page: () => MapPage(),
          transition: Transition.rightToLeft,
        ),
      ],
      initialRoute: '/',
      // home: const CustomBottomBar(),
    );
  }
}
