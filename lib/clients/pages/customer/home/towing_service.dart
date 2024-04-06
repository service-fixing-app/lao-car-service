import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/cover_image.dart';
import 'package:service_fixing/clients/components/customer/towingshop_section.dart';
import 'package:service_fixing/clients/components/find_map.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/constants.dart';

class TowingService extends StatefulWidget {
  const TowingService({super.key});

  @override
  State<TowingService> createState() => _TowingServiceState();
}

class _TowingServiceState extends State<TowingService> {
  final AuthController authController = Get.find();
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
                  'ຍິນດີຕ້ອນຮັບ Towing, ${userData['first_name']}',
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
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          const Expanded(
            child: SingleChildScrollView(
              child: TowingshopSection(),
            ),
          ),
        ],
      ),
    );
  }
}
