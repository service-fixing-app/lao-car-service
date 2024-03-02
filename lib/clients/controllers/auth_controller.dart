import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../pages/bottom/bottom_navigation.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var token = ''.obs;
  var isLoading = false.obs;
  var userData = {}.obs;

  Future<void> login(String tel, String password) async {
    try {
      isLoading(true);

      await Future.delayed(Duration(seconds: 2));
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/customer/login'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body:
            jsonEncode(<String, String>{'tel': tel, 'password': password}),
      );

      //print(response.statusCode);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        isAuthenticated.value = true;
        userData.value = responseData;
        print('User Data: $userData');
        Get.to(() => CustomBottomBar());
      } else {
        isAuthenticated.value = false;

        if (tel.isEmpty) {
          showErrorMessage('ກະລຸນາປ້ອນອີເມວ');
          return;
        } else if (password.isEmpty) {
          showErrorMessage('ກະລຸນາປ້ອນລະຫັດຜ່ານ');
          return;
        } else if (!isPasswordValid(password)) {
          showErrorMessage('ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ, ກະລຸນາປ້ອນຫຼາຍກວ່າ 6 ຕົວ');
        } else {
          showErrorMessage('ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ');
        }
      }
    } finally {
      isLoading(false);
    }
  }

  // bool isEmailValid(String email) {
  //   final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
  //   return emailRegex.hasMatch(email);
  // }

  bool isPasswordValid(String password) {
    return password.length >= 6;
  }

  void showErrorMessage(String message) {
    Get.snackbar(
      'ຂໍ້ຄວາມ',
      message,
      colorText: Colors.red,
      snackPosition: SnackPosition.TOP,
    );
  }
}
