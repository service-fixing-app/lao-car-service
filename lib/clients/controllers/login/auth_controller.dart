import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/pages/shop/bottom/shop_bottom.dart';
import '../../pages/customer/bottom/bottom_navigation.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var token = ''.obs;
  var isLoading = false.obs;
  var userData = {}.obs;

  // api for virtual emulator
  // String url = "http://10.0.2.2:5000/api/login/loginUser";
  // real android device
  String urlLogin = "http://192.168.43.127:5000/api/login/loginUser";

  Future<void> login(String tel, String password) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      final response = await http.post(
        Uri.parse(urlLogin),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'tel': tel, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        print("data: ${responseData}");
        final customerData = responseData['user'];
        final userId = customerData['customer_id'];
        // final userRole = customerData['role'];
        print("userId: ${userId}");
        isAuthenticated.value = true;
        await fetchUserData(); // Pass userRole here
      } else {
        isAuthenticated.value = false;
        print('user error ${response.statusCode}');
        Get.snackbar(
          'ການເຂົ້າສູ່ລະບົບຜິດພາດ',
          'ເບີໂທ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ, ກະລຸນາສອບຄືນໃໝ່',
          backgroundColor: Colors.white,
          colorText: Colors.red,
        );
        // Error handling
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/login/getUserByToken/${token.value}'),
        // Send token in the URL as a parameter
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        showCustomerData(responseData);
        navigateToRolePage(responseData['user']['role']);
      } else {
        // Error handling
        print("Failed to fetch user data: ${response.statusCode}");
      }
    } catch (e) {
      // Error handling
      print("Error fetching user data: $e");
    }
  }

  void navigateToRolePage(String role) {
    switch (role) {
      case 'customer':
        Get.offAll(() => const CustomBottomBar());
        break;
      case 'repairshop':
        Get.offAll(() => const ShopBottomBar());
        break;
      case 'towingshop':
        Get.offAll(() => const ShopBottomBar());
        break;
      default:
        // Handle unknown roles
        // print("Unknown role: $role");
        break;
    }
  }

  void showCustomerData(Map<String, dynamic> data) {
    // print('Received user data: $data');
    userData.value = data;
    // print('Updated user data: $userData');
  }
}
