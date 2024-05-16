import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class CustomerHistoryController extends GetxController {
  var messages = [].obs;
  var isLoading = true.obs;

  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchMessages();
  }

  Future<List<dynamic>> fetchMessages() async {
    try {
      final userData = authController.userData['user'];
      final int requestTel = userData['tel'];

      isLoading(true); // Set loading state to true

      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/request/getCustomerRequestsByTel/$requestTel'));
      if (response.statusCode == 200) {
        final List<dynamic> messagesJson =
            jsonDecode(response.body)['requests'];
        messages.assignAll(messagesJson);

        print('Fetched Messages: $messages');
      } else {
        print(
            'Failed to retrieve messages. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {
      isLoading(false);
      return [];
    }
  }
}
