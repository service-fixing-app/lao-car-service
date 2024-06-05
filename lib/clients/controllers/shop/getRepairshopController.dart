import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetRepairshopController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var getrepairshopData = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRepairshop();
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
}
