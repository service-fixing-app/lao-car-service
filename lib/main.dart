import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:service_fixing/clients/controllers/customer/register_controller.dart';
import 'package:service_fixing/clients/controllers/customer/verifieotp_controller.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/logout/logout.dart';
import 'package:service_fixing/clients/controllers/repairshop/verifieotp_controller.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/clients/controllers/shop/updateRepairshop_location.dart';
import 'package:service_fixing/clients/controllers/towingcarshop/towingcarshopVerifieOtp_controller.dart';
import 'package:service_fixing/clients/pages/login/login.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/login/verify_code.dart';
import 'package:service_fixing/clients/pages/register/customer/customer_form.dart';
import 'package:service_fixing/clients/pages/register/repairshop/repairshop_form.dart';
import 'package:service_fixing/clients/pages/register/towingcarshop/towingcarshop_form.dart';
import 'clients/controllers/repairshop/repairshopRegister_controller.dart';
import 'clients/pages/customer/bottom/bottom_navigation.dart';
import 'clients/pages/customer/home/home_page.dart';
import 'clients/pages/map/repairshop_map.dart';

// void main() {
//   runApp(
//     const MyApp(),
//   );
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(AuthController());
  Get.put(OtpController());
  Get.put(OtpRepairshopController());
  Get.put(CustomerRegisterController());
  Get.put(OtpTowingcarshopController());
  Get.put(RepairshopRegisterController());
  Get.put(OpenshopController());
  Get.put(LogoutController());
  Get.put(ShopLocationController());
  await GetStorage.init();
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
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId("60583f59-bff2-470f-992f-ea80cff08875");
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    // print("Accepted Permission : $accepted");
  });

  // runApp(const MaterialApp(
  //   home: MyApp(),
  // ));
  runApp(const MyApp());
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
          page: () => const LoginPage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/HomePage',
          page: () => const HomePage(),
          transition: Transition.fadeIn,
        ),
        GetPage(
          name: '/BottomBar',
          page: () => const CustomBottomBar(),
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
          name: '/towingtruckForm',
          page: () => const TowingcarshopForm(),
          transition: Transition.rightToLeft,
        ),
        GetPage(
          name: '/Map',
          page: () => MapPage(),
          transition: Transition.rightToLeft,
        ),
      ],
      initialRoute: '/',
    );
  }
}
