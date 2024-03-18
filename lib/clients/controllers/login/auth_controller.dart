import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../pages/bottom/bottom_navigation.dart';

// class AuthController extends GetxController {
//   static AuthController get to => Get.find();
//   var isAuthenticated = false.obs;
//   var token = ''.obs;
//   var isLoading = false.obs;
//   var userData = {}.obs;

//   Future<void> login(String tel, String password) async {
//     try {
//       isLoading(true);
//       await Future.delayed(const Duration(seconds: 2));
//       final response = await http.post(
//         Uri.parse('http://10.0.2.2:5000/api/customer/login'),
//         headers: <String, String>{'Content-Type': 'application/json'},
//         body: jsonEncode(<String, String>{'tel': tel, 'password': password}),
//       );

//       //print(response.statusCode);
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         token.value = responseData['token'];
//         isAuthenticated.value = true;
//         // userData.value = responseData;
//         // userData.value = responseData['customer'];
//         // userData.value = Customer.fromJson(responseData['customer']);
//         print('User Data: $userData');
//         print('User Data: ${userData['first_name']}');
//         showCustomerData(responseData['customer']);
//         Get.to(() => const CustomBottomBar());
//       } else {
//         isAuthenticated.value = false;

//         if (tel.isEmpty) {
//           showErrorMessage('ກະລຸນາປ້ອນອີເມວ');
//           return;
//         } else if (password.isEmpty) {
//           showErrorMessage('ກະລຸນາປ້ອນລະຫັດຜ່ານ');
//           return;
//         } else if (!isPasswordValid(password)) {
//           showErrorMessage('ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ, ກະລຸນາປ້ອນຫຼາຍກວ່າ 6 ຕົວ');
//         } else {
//           showErrorMessage('ອີເມວ ຫຼື ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ');
//         }
//       }
//     } finally {
//       isLoading(false);
//     }
//   }

//   // bool isEmailValid(String email) {
//   //   final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
//   //   return emailRegex.hasMatch(email);
//   // }

//   bool isPasswordValid(String password) {
//     return password.length >= 6;
//   }

//   void showErrorMessage(String message) {
//     Get.snackbar(
//       'ຂໍ້ຄວາມ',
//       message,
//       colorText: Colors.red,
//       snackPosition: SnackPosition.TOP,
//     );
//   }

//   void showCustomerData(Map<String, dynamic> data) {
//     print('Received user data: $data');
//     userData.value = data;
//     print('Updated user data: $userData');
//   }
// }
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
        Uri.parse('http://10.0.2.2:5000/api/customer/login'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, String>{'tel': tel, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        token.value = responseData['token'];
        // print("data: ${responseData}");
        final customerData = responseData['customer'];
        final userId = customerData['id'];
        print("userId: ${userId}");
        isAuthenticated.value = true;
        await fetchUserData(userId);
        Get.to(() => const CustomBottomBar());
      } else {
        isAuthenticated.value = false;
        // Error handling
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchUserData(int userId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5000/api/customer/getOneCustomer/$userId'),
        headers: <String, String>{'Authorization': 'Bearer ${token.value}'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("data from get: ${responseData}");
        showCustomerData(responseData);
      } else {
        // Error handling
      }
    } catch (e) {
      // Error handling
    }
  }

  void showCustomerData(Map<String, dynamic> data) {
    print('Received user data: $data');
    userData.value = data;
    print('Updated user data: $userData');
  }
}
