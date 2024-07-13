import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:service_fixing/constants.dart';

class Customer {
  final String firstName;
  final String lastName;
  final String tel;
  final String password;
  final String age;
  final String gender;
  final String birthdate;
  final String village;
  final String district;
  final String province;
  final File? profileImage;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.tel,
    required this.password,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.village,
    required this.district,
    required this.province,
    required this.profileImage,
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

class CustomerRegisterController extends GetxController {
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

  Future<void> customerRegistrationData(Customer customer) async {
    try {
      isLoading.value = true;
      // Check if customer already exists
      bool canRegister = await checkCustomer(customer.tel);
      if (!canRegister) {
        isSuccess.value = false;
        // print('Error: Telephone number already registered');
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
      String? imageUrl = await customer.uploadProfileImageToFirebaseStorage();

      // Send shop data along with image URL to database
      
        var response = await http.post(
          Uri.parse('http://192.168.43.127:5000/api/customer/addCustomer'),
          body: {
            'first_name': customer.firstName,
            'last_name': customer.lastName,
            'tel': customer.tel,
            'password': customer.password,
            'age': customer.age,
            'gender': customer.gender,
            'birthdate': customer.birthdate,
            'village': customer.village,
            'district': customer.district,
            'province': customer.province,
            'profile_image': imageUrl ?? '',
            'role': 'customer',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Registration successful
          isSuccess.value = true;
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

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
