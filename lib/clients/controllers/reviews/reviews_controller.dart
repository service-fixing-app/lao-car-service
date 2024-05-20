import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/requestion/customer_historyController.dart';
import 'package:service_fixing/clients/controllers/requestion/history_controller.dart';

// model
class Reviews {
  final String shopId;
  final double? rate;
  final String comment;

  Reviews({
    required this.shopId,
    this.rate,
    required this.comment,
  });
}

class ReviewsController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var ratingStarList = [].obs;
  final AuthController authController = Get.find();

  Future<void> addNewReviews(Reviews data) async {
    try {
      isLoading.value = true;
      final userData = authController.userData['user'];
      final String customerId = userData['id'];
      print("customerId : $customerId");
      // print("clatitude ${data.customerLatitude}");
      // print("clongitude ${data.customerLongitude}");
      var response = await http.post(
        Uri.parse('http://192.168.43.127:5000/api/reviews/addReviews'),
        body: {
          'shop_id': data.shopId,
          'customer_id': customerId,
          'shop_type': "repair",
          "rating": data.rate.toString(),
          "comment": data.comment
        },
      );
      // print("code status: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        print("Error: ${response.statusCode}");
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
            content: const Text('ສຳເລັດໃນການຄຳຕິຊົນ, ຂໍຂອບໃຈ'),
          ),
        );
        Get.back();
      } else {
        isSuccess.value = false;
        print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print(error);
      isSuccess.value = false;
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  void updateStatus(String messageId, String newStatus) async {
    try {
      final response = await http.put(
        Uri.parse(
            'http://192.168.43.127:5000/api/request/updateStatus/$messageId'),
        body: jsonEncode({'status': newStatus}),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        //print('Status updated successfully for message $messageId');
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
            content: const Text('ສຳເລັດໃນການຕອບກັບ, ຂໍຂອບໃຈ'),
          ),
        );
        try {
          await Get.find<CustomerHistoryController>().fetchMessages();
        } catch (e) {
          //print('Error fetching customer history messages: $e');
        }
        try {
          await Get.find<HistoryController>().fetchMessages();
        } catch (e) {
          //print('Error fetching history messages: $e');
        }
      } else {
        //print(
        //  'Failed to update  $messageId. Status code: ${response.statusCode}',
        //);
        //print('Response body: ${response.body}');
        throw Exception('Failed to update status for message $messageId');
      }
    } catch (e) {
      //print('Error: $e');
    }
  }

  Future<void> getRatingStar(String shopId) async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/reviews/getReviewsByShopId/$shopId'),
      );
      if (response.statusCode == 200) {
        final dynamic responseBody = jsonDecode(response.body);
        print('data: ${response.statusCode}');
        print('data: ${responseBody}');
        if (responseBody != null) {
          if (responseBody is List) {
            ratingStarList.assignAll(responseBody);
            //print('Fetched ratingStar for shop $shopId: $ratingStarList');
          } else {
            //print('Response body is not a list');
          }
        } else {
          //print('Response body is null');
        }
      } else {
        throw Exception('Failed to retrieve messages');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
