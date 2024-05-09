import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetRepairshopController extends GetxController {
  var getrepairshopData = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRepairshop();
  }

  Future<List<dynamic>> fetchRepairshop() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.43.127:5000/api/repairshop/allRepairshop'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        getrepairshopData.assignAll(data);

        print('Fetched Messages: $getrepairshopData');
      } else {
        print(
            'Failed to retrieve messages. Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
    return [];
  }
}
