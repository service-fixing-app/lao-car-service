import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class GetRepairshopController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var getrepairshopData = [].obs;
  var getOneRepairshop = {}.obs;
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchRepairshop();
    fetchOneRepairshop();
  }

  Future<List<dynamic>> fetchRepairshop() async {
    try {
      isLoading.value = true;
      final response = await http.get(
          Uri.parse('http://192.168.43.127:5000/api/repairshop/allRepairshop'));
      if (response.statusCode == 200) {
        isSuccess.value = true;
        final List<dynamic> data = jsonDecode(response.body);
        getrepairshopData.assignAll(data);
        // print('Fetched Messages: $getrepairshopData');
      } else {
        isSuccess.value = false;
        // print(Failed Status code: ${response.statusCode}');
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      // print('Error: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  Future<void> fetchOneRepairshop() async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/repairshop/getOneRepairshop/$id'));
      if (response.statusCode == 200) {
        isSuccess.value = true;
        final Map<String, dynamic> data = jsonDecode(response.body);
        getOneRepairshop.assignAll(data);
        print('Fetched customerData: $getOneRepairshop');
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
