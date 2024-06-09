import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class GetCustomerController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var getCustomerData = {}.obs;
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchCustomer();
  }

  Future<void> fetchCustomer() async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/customer/getOneCustomer/$id'));
      if (response.statusCode == 200) {
        isSuccess.value = true;
        final Map<String, dynamic> data = jsonDecode(response.body);
        getCustomerData.assignAll(data);
        print('Fetched customerData: $getCustomerData');
      } else {
        isSuccess.value = false;
        print('Failed Status code: ${response.statusCode}');
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      isSuccess.value = false;
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
