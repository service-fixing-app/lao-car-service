import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class TowingShopNewlocation {
  final String latitude;
  final String longitude;

  TowingShopNewlocation({
    required this.latitude,
    required this.longitude,
  });
}

class TowingShopLocationController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var shopLocations = <TowingShopNewlocation>[].obs;
  var specificLocation = TowingShopNewlocation(latitude: "", longitude: "").obs;
  final AuthController authController = Get.find();

  Future<void> shopLocationData(TowingShopNewlocation shop) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String shopId = userData['id'];
      //print("shopID: $shopId");

      var response = await http.put(
        Uri.parse(
            'http://192.168.43.127:5000/api/towingtruck/updateTowingtruck/$shopId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'latitude': shop.latitude,
          'longitude': shop.longitude,
          'permission_status': 'false'
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;
        // print('Success');
        Get.dialog(
          AlertDialog(
            icon: Image.asset(
              'assets/images/success.png',
              width: 50,
              height: 50,
            ),
            title: const Text(
              'Success',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content:
                const Text('ສຳເລັດໃນການເພີ່ມຕຳແໝ່ງທີ່ຢູ່ຂອງຮ້ານທ່ານ, ຂໍຂອບໃຈ'),
          ),
        );
        Get.find<AuthController>().fetchUserData();
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
