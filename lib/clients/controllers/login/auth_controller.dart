import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/pages/shop/bottom/shop_bottom.dart';
import '../../pages/customer/bottom/bottom_navigation.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var token = ''.obs;
  var isLoading = false.obs;
  var userData = {}.obs;

  Future<void> login(String tel, String password) async {
    try {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5000/api/login/loginUser'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'tel': tel, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        print("data: ${responseData}");
        final customerData = responseData['user'];
        final userId = customerData['id'];
        final userRole = customerData['role'];
        print("userId: ${userId}");
        isAuthenticated.value = true;
        await fetchUserData(userId, userRole); // Pass userRole here
      } else {
        isAuthenticated.value = false;
        // Error handling
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData(int userId, String userRole) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/api/login/getUserById/$userId'),
        headers: <String, String>{'Authorization': 'Bearer ${token.value}'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("data from get: $responseData");
        showCustomerData(responseData);
        navigateToRolePage(userRole); // Call navigateToRolePage here
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
        print("Unknown role: $role");
        break;
    }
  }

  void showCustomerData(Map<String, dynamic> data) {
    print('Received user data: $data');
    userData.value = data;
    print('Updated user data: $userData');
  }
}
