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
    fetchShopLocationsWithShopInfo();
  }

  // Method to fetch shop locations with repair shop info
  fetchShopLocationsWithShopInfo() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/repairshop/allRepairshop'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print('data location with shop info get : $data');
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
  // fetchShopLocationsWithShopInfo() async {
  //   try {
  //     var response = await http.get(
  //       Uri.parse(
  //           'http://192.168.43.127:5000/api/location/getLocationWithRepairShopInfo'),
  //     );
  //     if (response.statusCode == 200) {
  //       final List<dynamic> data = json.decode(response.body);
  //       print('data location with shop info get : $data');
  //       print(response.statusCode);
  //       // Update shopLocations with the fetched data
  //       shopLocations.assignAll(data
  //           .map((shop) => ({
  //                 'latitude': shop['latitude'],
  //                 'longitude': shop['longitude'],
  //                 'shopName': shop['shopInfo']['shop_name'],
  //                 'managerName': shop['shopInfo']['manager_name'],
  //                 'phoneNumber': shop['shopInfo']['tel'],
  //               }))
  //           .toList());

  //       isSuccess.value = true;
  //     } else {
  //       print('error');
  //     }
  //   } catch (error) {
  //     // Handle error
  //     print("Error fetching shop locations with shop info: $error");
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
