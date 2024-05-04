import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class ShopNewlocation {
  // final String shopId;
  // final String shopName;
  final String latitude;
  final String longitude;

  ShopNewlocation({
    // required this.shopId,
    // required this.shopName,
    required this.latitude,
    required this.longitude,
  });
}

class ShopLocationController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var shopLocations = <ShopNewlocation>[].obs;
  var specificLocation = ShopNewlocation(latitude: "", longitude: "").obs;
  final AuthController authController = Get.find();

  @override
  void onInit() {
    super.onInit();
    fetchShopLocations();
  }

  Future<void> shopLocationData(ShopNewlocation shop) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String shopName = userData['shop_name'];

      var response = await http.post(
        Uri.parse('http://192.168.43.127:5000/api/location/addNewShopLocation'),
        body: {
          'shop_name': shopName,
          'latitude': shop.latitude,
          'longitude': shop.longitude
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        print('success');
        Get.defaultDialog(
          title: 'ການເພີ່ມທີ່ຢູ່ຂອງຮ້ານທ່ານສຳເລັດແລ້ວ',
          middleText: 'ຂໍຂອບໃຈ!',
          backgroundColor: Colors.white,
          radius: 10.0,
          titleStyle: const TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16.0),
          middleTextStyle: const TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        );
      } else {
        // Registration failed
        isSuccess.value = false;
        print("Error: ${response.statusCode}");
        if (response.statusCode == 400) {
          print('Validation error: ${response.body}');
        } else {
          print('Server error');
        }
      }
    } catch (error) {
      // Handle network errors or exceptions
      isSuccess.value = false;
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  fetchShopLocations() async {
    try {
      var response = await http.get(
        Uri.parse('http://192.168.43.127:5000/api/location/getAllShopLocation'),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = json.decode(response.body);
        // print('data location : $data');
        // print(response.statusCode);
        shopLocations.assignAll(data
            .map((shop) => ShopNewlocation(
                  latitude: shop['latitude'],
                  longitude: shop['longitude'],
                ))
            .toList());
      } else {
        // print('error');
      }
    } catch (error) {
      // Handle error
      print("Error fetching shop locations: $error");
    } finally {
      isLoading.value = false;
    }
  }

  fetchShopLocationsByShopName(String shopName) async {
    try {
      var response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/location/getShopLocationByShopName/$shopName'),
      );
      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        double latitude = data['latitude']; // Parsing latitude as double
        double longitude = data['longitude']; // Parsing longitude as double

        specificLocation.value = ShopNewlocation(
          latitude: latitude.toString(),
          longitude: longitude.toString(),
        );

        // print(response.statusCode);
      } else {
        // Handle error
        print('Error fetching shop locations: ${response.statusCode}');
      }
    } catch (error) {
      // Handle error
      print('Error fetching shop locations: $error');
    }
  }

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
