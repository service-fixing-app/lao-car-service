import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/requestion/customer_historyController.dart';
import 'package:service_fixing/clients/controllers/requestion/history_controller.dart';
import 'package:service_fixing/clients/pages/customer/services/success.dart';
import 'package:service_fixing/constants.dart';

// model
class Request {
  final String senderName;
  final String? customerId;
  final String? shopId;
  final String senderTel;
  final String receiverName;
  final String receiverTel;
  final double? customerLatitude;
  final double? customerLongitude;
  final String message;

  Request({
    required this.senderName,
    this.customerId,
    this.shopId,
    required this.senderTel,
    required this.receiverName,
    required this.receiverTel,
    this.customerLatitude,
    this.customerLongitude,
    required this.message,
  });
}

class RequestController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<bool> checkCustomerStatus(String customerId) async {
    try {
      var response = await http.get(
        Uri.parse(
          'http://192.168.43.127:5000/api/request/getCustomerRequestById/$customerId',
        ),
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true) {
          var requests = data['requests'];
          for (var request in requests) {
            if (request['status'] == 'warning') {
              return false; // Found a request with status 'warning'
            }
          }
        }
        return true; // No request with status 'warning' found
      } else {
        throw Exception('Failed Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error checking customer status: $e');
      throw Exception('Failed to load customer status: $e');
    }
  }

  Future<void> requestmessageData(Request message) async {
    try {
      isLoading.value = true;
      // print("shopId ${message.shopId}");
      // print("customerId ${message.customerId}");
      // print("clatitude ${message.customerLatitude}");
      // print("clongitude ${message.customerLongitude}");

      if (message.customerId != null) {
        bool canSendRequest = await checkCustomerStatus(message.customerId!);
        if (!canSendRequest) {
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
                    'ທ່ານບໍ່ສາມາດຮ້ອງຂໍໄດ້',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  content: const Text(
                      'ກະລຸນາຍົກເລີກຮ້ານທີ່ເຄີຍຮ້ອງຂໍບໍລິການກ່ອນໝ້ານີ້ກ່ອນ. ຂໍຂອບໃຈ'),
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

          isSuccess.value = false;
          return;
        }
      }
      var response = await http.post(
        Uri.parse('http://192.168.43.127:5000/api/request/sendMessage'),
        body: {
          'shop_id': message.shopId,
          'customer_id': message.customerId,
          'sender_name': message.senderName,
          'sender_tel': message.senderTel,
          'receiver_name': message.receiverName,
          'receiver_tel': message.receiverTel,
          'clatitude': message.customerLatitude.toString(),
          'clongitude': message.customerLongitude.toString(),
          'message': message.message,
          'status': 'warning',
        },
      );
      // print("code status: ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        await callNotificationAPI();
        print("Error: ${response.statusCode}");
        // Get.offAll(const HomePage());
        Get.to(const Successs());
      } else {
        isSuccess.value = false;
        // print("Error: ${response.statusCode}");
      }
    } catch (error) {
      print(error);
      isSuccess.value = false;
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> callNotificationAPI() async {
    try {
      var devices = ["d6c79b80-02b8-4f81-8f51-50c3e49e94b1"];
      var response = await http.post(
        Uri.parse(
            'http://192.168.43.127:5000/api/notification/pushNotificationToDevice'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
        },
        body: jsonEncode({
          'devices': devices,
        }),
      );

      if (response.statusCode == 200) {
        // Notification API call successful
        //print("send successful");
      } else {
        //print("send notification failed: ${response.statusCode}");
        //print("Response body: ${response.body}");
      }
    } catch (error) {
      // Handle network errors or exceptions
      //print("Error sending notification: $error");
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

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
