import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GetTowingshopController extends GetxController {
  var getTowingshopData = [].obs;
  var shopLocations = [].obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchRepairshop();
    fetchTowingshopLocation();
  }

  fetchTowingshopLocation() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/towingtruck/allTowingtruck'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('data location with towingshop info get : $data');
        print(response.statusCode);
        // Update shopLocations with the fetched data
        shopLocations.assignAll(data
            .where(
                (shop) => shop['latitude'] != null && shop['longitude'] != null)
            .map((shop) => {
                  'id': shop['id'],
                  'latitude': shop['latitude'],
                  'longitude': shop['longitude'],
                  'shopName': shop['shop_name'],
                  'managerName': shop['manager_name'],
                  'phoneNumber': shop['tel'],
                  'Status': shop['status'],
                  'permission': shop['permission_status'],
                })
            .toList());
        isSuccess.value = true;
      } else {
        print('error');
      }
    } catch (error) {
      // Handle error
      print("Error fetching shop locations with shop info: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<dynamic>> fetchRepairshop() async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/towingtruck/allTowingtruck'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        getTowingshopData.assignAll(data);

        print('Fetched Messages: $getTowingshopData');
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
