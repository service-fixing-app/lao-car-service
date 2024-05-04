import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_fixing/clients/controllers/requestion/customer_historyController.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/constants.dart';

class CustomerHistory extends StatefulWidget {
  @override
  _CustomerHistoryState createState() => _CustomerHistoryState();
}

class _CustomerHistoryState extends State<CustomerHistory> {
  final CustomerHistoryController historyController =
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
      body: historyController.messages.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              reverse: true,
              itemCount: historyController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = historyController.messages[index];
                return _buildNotificationItem(
                  profileImage: const AssetImage('assets/images/man.png'),
                  date: formatDateString(
                      message['createdAt']), // Format the date string
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
                      // const SizedBox(
                      //   width: 10,
                      // ),
                      // // Display Accept button if status is not completed
                      // if (status != 'completed' && status != 'cancelled')
                      //   SizedBox(
                      //     // width: 100,
                      //     child: ElevatedButton(
                      //       onPressed: onAccept,
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.blue,
                      //         shape: RoundedRectangleBorder(
                      //           borderRadius: BorderRadius.circular(50),
                      //         ),
                      //         elevation: 3.0,
                      //       ),
                      //       child: const Text(
                      //         'ຮັບຮ້ອງຂໍ',
                      //         style: TextStyle(
                      //           fontSize: 14,
                      //           fontFamily: 'phetsarath_ot',
                      //           fontWeight: FontWeight.w500,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
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
