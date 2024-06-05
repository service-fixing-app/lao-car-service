import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class ReviewsImage {
  final List<File>? reviewsShopImageFiles;

  ReviewsImage({
    required this.reviewsShopImageFiles,
  });

  Future<List<String>?> uploadDocumentImagesToFirebaseStorage() async {
    try {
      if (reviewsShopImageFiles == null || reviewsShopImageFiles!.isEmpty) {
        return null;
      }

      List<String> imageUrls = [];

      for (var file in reviewsShopImageFiles!) {
        // Generate a unique short name for the image
        String imageName =
            DateTime.now().millisecondsSinceEpoch.toString() + ".jpg";

        // Upload image to Firebase Storage with the short name
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('ReviewsShopImages/$imageName');
        await ref.putFile(file);

        // Get download URL of the uploaded image
        String imageUrl = await ref.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      return imageUrls;
    } catch (e) {
      print('Error uploading document images to Firebase Storage: $e');
      return null;
    }
  }
}

class UpdateRepairshopReviewImage extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  final AuthController authController = Get.find();

  Future<void> addShopReviewImage(ReviewsImage reviewsImage) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String shopId = userData['id'];
      print('shop id : $shopId');

      // Upload images to Firebase Storage
      List<String>? imageUrls =
          await reviewsImage.uploadDocumentImagesToFirebaseStorage();

      if (imageUrls == null || imageUrls.isEmpty) {
        isSuccess.value = false;
        return;
      }
      // print('shop image : $imageUrls');

      var response = await http.post(
        Uri.parse(
            'http://192.168.43.127:5000/api/reviewsShopImage/addReviewsShopImage'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'shop_id': shopId,
          'images': imageUrls,
        }),
      );
      // print('statuscode:   ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;
        // print('Successs  ${response.statusCode}');
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
                const Text('ສຳເລັດໃນການເພີ່ມຕຳແໝ່ງທີ່ຢູ່ຂອງຮ້ານທ່ານ, ຂອບໃຈ'),
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
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }


  // function update shop reviews Image
  Future<void> shopReviewImageData(ReviewsImage reviewsImage) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String shopId = userData['id'];
      // print('shop id : $shopId');

      // Upload images to Firebase Storage
      List<String>? imageUrls =
          await reviewsImage.uploadDocumentImagesToFirebaseStorage();

      if (imageUrls == null || imageUrls.isEmpty) {
        isSuccess.value = false;
        return;
      }

      print('shop image : $imageUrls');

      var response = await http.put(
        Uri.parse(
            'http://192.168.43.127:5000/api/repairshop/updateRepairshop/$shopId'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'reviewsshop_image': imageUrls,
        }),
      );
      print('statuscode:   ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;
        print('Successs  ${response.statusCode}');
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
                const Text('ສຳເລັດໃນການເພີ່ມຕຳແໝ່ງທີ່ຢູ່ຂອງຮ້ານທ່ານ, ຂອບໃຈ'),
          ),
        );
        Get.find<AuthController>().fetchUserData();
      } else {
        isSuccess.value = false;
        print("Error: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (error) {
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
