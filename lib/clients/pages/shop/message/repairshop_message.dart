import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:service_fixing/clients/controllers/requestion/history_controller.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/clients/pages/map/repairshop_map.dart';
import 'package:service_fixing/constants.dart';
import 'package:shimmer/shimmer.dart';

class RepairShopMessage extends StatefulWidget {
  @override
  _RepairShopMessageState createState() => _RepairShopMessageState();
}

class _RepairShopMessageState extends State<RepairShopMessage> {
  final HistoryController historyController = Get.put(HistoryController());
  final RequestController requestController = Get.put(RequestController());

  // Function to format the date string
  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }

  void initNotification() async {
    OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
    OneSignal.shared.setAppId("60583f59-bff2-470f-992f-ea80cff08875");
    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      // print("Accepted Permission : $accepted");
    });
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
          if (historyController.isLoading.value) {
            return buildShimmerLoading();
          } else if (historyController.messages.isEmpty) {
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
              itemCount: historyController.messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = historyController.messages[index];
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
                  onTap: () {
                    double clatitude = message['clatitude'];
                    double clongitude = message['clongitude'];
                    Get.to(() => MapPage(
                          customerlatitude: clatitude,
                          customerclongitude: clongitude,
                        ));
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
    required Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 15.0,
        ),
        child: InkWell(
          onTap: onTap,
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
                          // Display Cancel button if status is not completed or cancelled
                          SizedBox(
                            width: 100,
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
                                'ຍົກເລີກ',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'phetsarath_ot',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        // Display Accept button if status is not completed
                        if (status != 'completed' && status != 'cancelled')
                          SizedBox(
                            // width: 100,
                            child: ElevatedButton(
                              onPressed: onAccept,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                elevation: 3.0,
                              ),
                              child: const Text(
                                'ຮັບຮ້ອງຂໍ',
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
