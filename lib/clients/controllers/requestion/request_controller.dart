import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/controllers/requestion/history_controller.dart';
import 'package:service_fixing/clients/pages/customer/services/success.dart';

// model
class Request {
  final String senderName;
  final String senderTel;
  final String receiverName;
  final String receiverTel;
  final String message;

  Request({
    required this.senderName,
    required this.senderTel,
    required this.receiverName,
    required this.receiverTel,
    required this.message,
  });
}

class RequestController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  

  Future<void> requestmessageData(Request message) async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('http://192.168.43.127:5000/api/request/sendMessage'),
        body: {
          'sender_name': message.senderName,
          'sender_tel': message.senderTel,
          'receiver_name': message.receiverName,
          'receiver_tel': message.receiverTel,
          'message': message.message,
          'status': 'warning',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        await callNotificationAPI();
        //print("Error: ${response.statusCode}");
        // Get.offAll(const HomePage());
        Get.to(const Successs());
      } else {
        isSuccess.value = false;
        // print("Error: ${response.statusCode}");
      }
    } catch (error) {
      //print(error);
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
            'http://192.168.43.127:5000/api/request//updateStatus/$messageId'),
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
        Get.find<HistoryController>().fetchMessages();
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
