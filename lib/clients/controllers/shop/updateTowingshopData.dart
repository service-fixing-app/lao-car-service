import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/shop/getTowingshopController.dart';

class UpdateTowingshopData {
  final String? shopName;
  final String? owerName;
  final String? tel;
  final String? password;
  final String? age;
  final String? gender;
  final String? village;
  final String? district;
  final String? province;
  final String? typeService;
  File? profileImage;
  final String? existingProfileImageUrl;

  UpdateTowingshopData({
    this.shopName,
    this.owerName,
    this.tel,
    this.password,
    this.age,
    this.gender,
    this.village,
    this.district,
    this.province,
    this.typeService,
    this.profileImage,
    this.existingProfileImageUrl,
  });

  Future<String?> uploadProfileImageToFirebaseStorage() async {
    try {
      if (profileImage == null) return existingProfileImageUrl;

      // Get image name
      String imageName = profileImage!.path.split('/').last;

      // Upload image to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('Images/$imageName');
      await ref.putFile(File(profileImage!.path));

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return existingProfileImageUrl;
    }
  }
}

class UpdateTowingshopController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  final AuthController authController = Get.find();

  Future<void> updateTowingshopData(UpdateTowingshopData data) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      //print("shopID: $shopId");
      String? imageUrl = await data.uploadProfileImageToFirebaseStorage();

      var response = await http.put(
        Uri.parse(
            'http://192.168.43.127:5000/api/towingtruck/updateTowingtruck/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'shop_name': data.shopName,
          'manager_name': data.owerName,
          'tel': data.tel,
          'password': data.password,
          'age': data.age,
          'gender': data.gender,
          'village': data.village,
          'district': data.district,
          'province': data.province,
          'type_service': data.typeService,
          'profile_image': imageUrl ?? data.existingProfileImageUrl,
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
              'ຂໍ້ຄວາມສຳເລັດ',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            content: const Text('ການແກ້ໄຂຂໍ້ມູນທ່ານສຳເລັດ\nຂໍຂອບໃຈ'),
          ),
        );

        try {
          Get.find<GetTowingshopController>().fetchOneTowingshop();
        } catch (e) {
          print("Error: $e");
        }
        try {
          Get.find<GetTowingshopController>().fetchTowingshop();
        } catch (e) {
          print("Error: $e");
        }
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
