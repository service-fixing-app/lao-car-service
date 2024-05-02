import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/body_section.dart';
import 'package:service_fixing/clients/components/cover_image.dart';
import 'package:service_fixing/clients/components/find_map.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/constants.dart';

class ShopHomePage extends StatefulWidget {
  const ShopHomePage({Key? key}) : super(key: key);

  @override
  State<ShopHomePage> createState() => _ShopHomePageState();
}

class _ShopHomePageState extends State<ShopHomePage> {
  final AuthController authController = Get.find();
  // final HistoryController historyController = Get.find();

  @override
  Widget build(BuildContext context) {
    final userData = authController.userData['user'];
    // print('User Data: ${authController.userData}');
    int newMessageCount = 11;
    return Scaffold(
      backgroundColor: bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const CoverImage(),
              const Positioned(
                top: CoverImage.coverHeight / 1.2,
                left: 0,
                right: 0,
                child: FindMap(),
              ),
              Positioned(
                top: 60,
                left: 10,
                right: 0,
                child: Text(
                  'ຍິນດີຕ້ອນຮັບ, ${userData['manager_name']}',
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
              const Positioned(
                top: 56,
                left: 290,
                child: Icon(
                  Icons.notifications_active,
                  color: Colors.grey,
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
            child: SingleChildScrollView(
              child: BodySection(),
            ),
          ),
        ],
      ),
    );
  }
}
