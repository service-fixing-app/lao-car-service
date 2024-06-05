import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/cover_imagetowing.dart';
import 'package:service_fixing/clients/components/customer/towingshop_section.dart';
import 'package:service_fixing/clients/components/findtowing_map.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/requestion/customer_historyController.dart';
import 'package:service_fixing/clients/pages/customer/history/customer_history.dart';
import 'package:service_fixing/constants.dart';

class TowingService extends StatefulWidget {
  const TowingService({super.key});

  @override
  State<TowingService> createState() => _TowingServiceState();
}

class _TowingServiceState extends State<TowingService> {
  final AuthController authController = Get.find();
  final CustomerHistoryController customerHistoryController =
      Get.put(CustomerHistoryController());
  int newMessageCount = 0;
  void fetchMessagesAndCount() async {
    await Get.find<CustomerHistoryController>().fetchMessages();
    setState(() {
      newMessageCount = customerHistoryController.messages
          .where((message) => message['status'] == 'warning')
          .length;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchMessagesAndCount();
  }

  @override
  Widget build(BuildContext context) {
    final userData = authController.userData['user'];
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const CoverImageTowingShop(),
              const Positioned(
                top: CoverImageTowingShop.coverHeight / 1.2,
                left: 0,
                right: 0,
                child: FindTowingMap(),
              ),
              Positioned(
                top: 60,
                left: 10,
                right: 0,
                child: Text(
                  'ຍິນດີຕ້ອນຮັບ, ${userData['first_name']}',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w600,
                    color: primaryColor,
                    shadows: [
                      Shadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-1, -1),
                        blurRadius: 1,
                      ),
                      Shadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-1, -1),
                        blurRadius: 1,
                      ),
                      Shadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-1, -1),
                        blurRadius: 1,
                      ),
                      Shadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(-1, -1),
                        blurRadius: 1,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 50,
                left: 285,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: 56,
                left: 290,
                child: InkWell(
                  onTap: () {
                    Get.to(() => CustomerHistory());
                  },
                  child: const Icon(
                    Icons.notifications_active,
                    color: Colors.grey,
                  ),
                ),
              ),
              if (newMessageCount > 0)
                Positioned(
                  top: 45,
                  left: 310,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      newMessageCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Expanded(
            child: TowingshopSection(),
          ),
        ],
      ),
    );
  }
}
