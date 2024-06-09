import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/shop/getCustomerController.dart';

class UpdateCustomerData {
  final String? firstName;
  final String? lastName;
  final String? tel;
  final String? password;
  final String? age;
  final String? gender;
  final String? village;
  final String? district;
  final String? province;
  File? profileImage;

  UpdateCustomerData({
    this.firstName,
    this.lastName,
    this.tel,
    this.password,
    this.age,
    this.gender,
    this.village,
    this.district,
    this.province,
    this.profileImage,
  });
  Future<String?> uploadProfileImageToFirebaseStorage() async {
    try {
      if (profileImage == null) return null;

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
      return null;
    }
  }
}

class UpdateCustomerController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  final AuthController authController = Get.find();

  Future<void> updateCustomerData(UpdateCustomerData data) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String id = userData['id'];
      //print("shopID: $shopId");
      String? imageUrl = await data.uploadProfileImageToFirebaseStorage();

      var response = await http.put(
        Uri.parse('http://192.168.43.127:5000/api/customer/updateCustomer/$id'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'first_name': data.firstName,
          'last_name': data.lastName,
          'tel': data.tel,
          'password': data.password,
          'age': data.age,
          'gender': data.gender,
          'village': data.village,
          'district': data.district,
          'province': data.province,
          'profile_image': imageUrl,
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
            content: const Column(
              children: [
                Text('ການແກ້ໄຂຂໍ້ມູນທ່ານສຳເລັດ'),
                Text('ຂໍຂອບໃຈ'),
              ],
            ),
          ),
        );
        Get.find<GetCustomerController>().fetchCustomer();
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
