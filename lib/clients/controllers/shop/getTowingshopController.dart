import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class GetTowingshopController extends GetxController {
  var getTowingshopData = [].obs;
  var shopLocations = [].obs;
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var getOneTowingshop = {}.obs;
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchTowingshop();
    fetchTowingshopLocation();
    fetchOneTowingshop();
  }

  fetchTowingshopLocation() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/towingtruck/allTowingtruck'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        // print('data location with towingshop info get : $data');
        // print(response.statusCode);
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
      // print("Error fetching shop locations with shop info: $error");
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<dynamic>> fetchTowingshop() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/towingtruck/allTowingtruck'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        getTowingshopData.assignAll(data);
        // print('Fetched Messages: $getTowingshopData');
      } else {
        // print('Status code: ${response.statusCode}');
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    } finally {
      isLoading.value = false;
    }
    return [];
  }

  Future<void> fetchOneTowingshop() async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      final response = await http.get(Uri.parse(
          'http://192.168.43.127:5000/api/towingtruck/getOneTowingtruck/$id'));
      if (response.statusCode == 200) {
        isSuccess.value = true;
        final Map<String, dynamic> data = jsonDecode(response.body);
        getOneTowingshop.assignAll(data);
        print('Fetched customerData: $getOneTowingshop');
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
