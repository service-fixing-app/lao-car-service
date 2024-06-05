import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_fixing/clients/controllers/requestion/customer_historyController.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/constants.dart';
import 'package:shimmer/shimmer.dart';

class CustomerHistory extends StatefulWidget {
  @override
  _CustomerHistoryState createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  final CustomerHistoryController customerHistoryController =
      Get.put(CustomerHistoryController());
  final RequestController requestController = Get.put(RequestController());

  // Function to format the date string
  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຂໍ້ຄວາມ',
          style: TextStyle(
            fontFamily: 'phetsarath_ot',
          ),
        ),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      backgroundColor: bgColor,
      body: Obx(
        () {
          if (customerHistoryController.isLoading.value) {
            return buildShimmerLoading();
          } else if (customerHistoryController.messages.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty-folder.png',
                    fit: BoxFit.cover,
                  ),
                  const Text('ຍັງບໍ່ມີຂໍ້ຄວາມຮ້ອງຂໍ',
                      style: TextStyle(fontSize: 14)),
                ],
              ),
            );
          } else {
            return ListView.builder(
              reverse: true,
              itemCount: customerHistoryController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = customerHistoryController.messages[index];
                return _buildNotificationItem(
                  profileImage: const AssetImage('assets/images/man.png'),
                  date: formatDateString(message['createdAt']),
                  senderName: message['receiver_name'],
                  content: message['message'],
                  status: message['status'],
                  onAccept: () {
                    // Call method to update status
                    requestController.updateStatus(message['id'], 'completed');
                  },
                  onCancel: () {
                    // Call method to update status to cancelled
                    requestController.updateStatus(message['id'], 'cancelled');
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildNotificationItem({
    required AssetImage profileImage,
    required String date,
    required String senderName,
    required String content,
    required String status,
    required Function() onAccept,
    required Function() onCancel,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 18.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: profileImage,
              radius: 25,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  Text(content),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Display text if status is completed
                      if (status == 'completed')
                        const Text(
                          'ສຳເລັດແລ້ວ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'phetsarath_ot',
                            fontWeight: FontWeight.w500,
                            color: Colors.green,
                          ),
                        )
                      // Display text if status is cancelled
                      else if (status == 'cancelled')
                        const Text(
                          'ຍົກເລີກການຮ້ອງຂໍແລ້ວ',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'phetsarath_ot',
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        )
                      else
                        SizedBox(
                          // width: 100,
                          child: ElevatedButton(
                            onPressed: onCancel,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              elevation: 3.0,
                            ),
                            child: const Text(
                              'ປ່ຽນຮ້ານບໍລິການໃໝ່',
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'phetsarath_ot',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return _buildShimmerNotificationItem();
        },
      ),
    );
  }

  Widget _buildShimmerNotificationItem() {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white, // Background color of the container
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 18.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // image
            CircleAvatar(
              backgroundColor: Colors.grey[300], // Shimmer base color
              radius: 25,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // text
                      Container(
                        height: 10.0,
                        width: 100.0,
                        color: Colors.grey[300], // Shimmer base color
                      ),
                      // text
                      Container(
                        height: 10.0,
                        width: 50.0,
                        color: Colors.grey[300], // Shimmer base color
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  // text
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.grey[300], // Shimmer base color
                  ),
                  const SizedBox(
                    height: 4.0,
                  ),
                  // text
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.grey[300], // Shimmer base color
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // button
                      Container(
                        width: 150.0,
                        height: 40.0,
                        color: Colors.grey[300], // Shimmer base color
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
