import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class GetRequestRepairController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var requestRepairData = <Map<String, dynamic>>[].obs;
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchRequestRepairData();
  }

  Future<void> fetchRequestRepairData() async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      final response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/request/getRepairshop-RequestById/$id'),
      );
      if (response.statusCode == 200) {
        isSuccess.value = true;
        final responseData = json.decode(response.body);
        requestRepairData.value = List<Map<String, dynamic>>.from(responseData);
        print('Successfully fetched repair data $requestRepairData');
      } else {
        // Error handling
        isSuccess.value = false;
        print("Failed to fetch repair data: ${response.statusCode}");
      }
    } catch (e) {
      // Error handling
      isSuccess.value = false;
      print("Error fetching repair data: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
