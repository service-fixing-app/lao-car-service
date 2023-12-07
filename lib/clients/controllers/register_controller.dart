import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../pages/login_page.dart';

class RegisterController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> signup(String fullname, String email, String password) async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/signup'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{
          'fullname': fullname,
          'email': email,
          'password': password,
        }),
      );

      print(response.statusCode);

      if (response.statusCode == 200) {
        // Registration successful
        isSuccess.value = true;
        Get.to(() => const LoginPage());
      } else {
        // Registration failed
        isSuccess.value = false;
        print("Error: ${response.statusCode}");
        Get.to(() => const LoginPage());
      }
    } catch (error) {
      // Handle network errors or exceptions
      print("Error: $error");
      isSuccess.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  // Reset the state when leaving the page
  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
