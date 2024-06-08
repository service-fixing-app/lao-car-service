import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:service_fixing/constants.dart';

class Repairshop {
  final String shopName;
  final String shopownerName;
  final String tel;
  final String password;
  final String age;
  final String gender;
  final String birthdate;
  final String village;
  final String district;
  final String province;
  final String typeService;
  final File? profileImage;
  final File? documentImage;
  Repairshop({
    required this.shopName,
    required this.shopownerName,
    required this.tel,
    required this.password,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.village,
    required this.district,
    required this.province,
    required this.typeService,
    required this.profileImage,
    required this.documentImage,
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

  Future<String?> uploadDocumentImageToFirebaseStorage() async {
    try {
      if (documentImage == null) return null;

      // Get image name
      String imageName = documentImage!.path.split('/').last;

      // Upload image to Firebase Storage
      Reference ref =
          FirebaseStorage.instance.ref().child('Documents/$imageName');
      await ref.putFile(File(documentImage!.path));

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading document image to Firebase Storage: $e');
      return null;
    }
  }
}

class RepairshopRegisterController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<bool> checkCustomer(String tel) async {
    try {
      final urls = [
        'http://192.168.43.127:5000/api/customer/getCustomerByTel/$tel',
        'http://192.168.43.127:5000/api/repairshop/getRepairshopByTel/$tel',
        'http://192.168.43.127:5000/api/towingtruck/getTowingtruckByTel/$tel',
      ];

      for (var url in urls) {
        var response = await http.get(Uri.parse(url));
        if (response.statusCode == 200) {
          var data = json.decode(response.body);
          print("data get from check : $data");
          if (data is List && data.isNotEmpty && data[0]['tel'] != null) {
            return false;
          }
        } else {
          throw Exception(
              'Failed Status code: ${response.statusCode} for URL: $url');
        }
      }
      return true;
    } catch (e) {
      print('Error checking customer tel: $e');
      throw Exception('Failed to load customer tel: $e');
    }
  }

  Future<void> repairshopRegistrationData(Repairshop shop) async {
    try {
      isLoading.value = true;
      bool canRegister = await checkCustomer(shop.tel);
      if (!canRegister) {
        isSuccess.value = false;
        print('Error: Telephone number already registered');
        Get.dialog(
          Builder(
            builder: (context) {
              return AlertDialog(
                icon: Image.asset(
                  'assets/images/warning.png',
                  width: 50,
                  height: 50,
                ),
                title: const Text(
                  'ທ່ານບໍ່ສາມາດລົງທະບຽນໄດ້',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
                content: const Text(
                    'ກະລຸນາກວດສອບເບີຂອງທ່ານຄືນໃໝ່ ເບີອາດເຄີຍລົງທະບຽນມາກ່ອນແລ້ວ. ຂໍຂອບໃຈ'),
                actions: [
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('ຕົກລົງ'),
                  ),
                ],
              );
            },
          ),
        );
        return;
      }

      // Upload profile image to Firebase Storage and get image URL
      String? imageUrl = await shop.uploadProfileImageToFirebaseStorage();

      // Upload document image to Firebase Storage and get image URL
      String? documentImageUrl =
          await shop.uploadDocumentImageToFirebaseStorage();

      // Send shop data along with image URL to database
      if (imageUrl != null) {
        var response = await http.post(
          Uri.parse('http://192.168.43.127:5000/api/repairshop/addRepairshop'),
          body: {
            'shop_name': shop.shopName,
            'manager_name': shop.shopownerName,
            'tel': shop.tel,
            'password': shop.password,
            'age': shop.age,
            'gender': shop.gender,
            'birthdate': shop.birthdate,
            'village': shop.village,
            'district': shop.district,
            'province': shop.province,
            'type_service': shop.typeService,
            'profile_image': imageUrl, // Send the image URL to the database
            'document_verify':
                documentImageUrl, // Send the image URL to the database
            'role': 'repairshop',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Registration successful
          isSuccess.value = true;
          // Navigate to success page or perform other actions
        } else {
          // Registration failed
          isSuccess.value = false;
          print("Error: ${response.statusCode}");
          if (response.statusCode == 400) {
            // Handle validation errors
            print('Validation error: ${response.body}');
            // Display validation errors to the user or perform other actions
          } else {
            // Handle other errors (e.g., server errors)
            print('Server error');
            // Display a generic error message to the user or perform other actions
          }
        }
      } else {
        print('Error: Image upload failed');
        isSuccess.value = false;
      }
    } catch (error) {
      // Handle network errors or exceptions
      isSuccess.value = false;
      print("Error: $error");
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
