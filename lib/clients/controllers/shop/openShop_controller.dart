import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class Status {
  final String status;

  Status({
    required this.status,
  });
}

class OpenshopController extends GetxController {
  var isOpen = false.obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;
  late AuthController authController;

  @override
  void onInit() {
    super.onInit();
    try {
      authController = Get.find<AuthController>();
      fetchCurrentStatus();
    } catch (e) {
      print('Failed to find AuthController: $e');
    }
  }

  Future<void> fetchCurrentStatus() async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String shopId = userData['id'];
      var response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/repairshop/getOneRepairshop/$shopId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var status = data['status'];
        isOpen.value = status == 'ເປີດ';
      } else {
        print('Failed to fetch shop status: ${response.statusCode}');
      }
    } catch (error) {
      print('An error occurred: $error');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openshopUpdate(Status status) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];

      final String shopId = userData['id'];

      var response = await http.put(
        Uri.parse(
            'http://192.168.43.127:5000/api/repairshop/updateRepairshop/$shopId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'status': status.status}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;
        print('Status update success');

        // Fetch the current status again to update the UI
        await fetchCurrentStatus();
      } else {
        isSuccess.value = false;
        // print("Error: ${response.statusCode}");
        // print("Response body: ${response.body}");
      }
    } catch (error) {
      isSuccess.value = false;
      // print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
