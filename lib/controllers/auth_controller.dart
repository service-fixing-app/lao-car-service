import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  var isAuthenticated = false.obs;
  var token = ''.obs;

  Future<void> login(String email, String password) async {
    final response = await http.post(
      // api endpoint here
      Uri.parse(
          'http://10.0.2.2:5000/api/login'), // Replace with your API endpoint
      headers: <String, String>{'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );

    print(response.statusCode);
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      token.value = responseData['token'];
      isAuthenticated.value = true;
      Get.offNamed('/home'); // Navigate to the home page on successful login
    } else {
      isAuthenticated.value = false;
      // Handle login failure here
    }
  }
}
