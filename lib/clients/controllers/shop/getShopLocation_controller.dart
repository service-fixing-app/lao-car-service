import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetShopLocationController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var shopLocations = [].obs;
  @override
  void onInit() {
    super.onInit();
    fetchShopLocations();
  }

  fetchShopLocations() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/location/getAllShopLocation'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);
        print('data location get : $data');
        print(response.statusCode);
        shopLocations.assignAll(data
            .map((shop) => (
                  latitude: shop['latitude'],
                  longitude: shop['longitude'],
                ))
            .toList());
      } else {
        print('error');
      }
    } catch (error) {
      // Handle error
      print("Error fetching shop locations: $error");
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
