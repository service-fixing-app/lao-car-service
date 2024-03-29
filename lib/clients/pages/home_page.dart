import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/body_section.dart';
import 'package:service_fixing/clients/components/find_map.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/constants.dart';
import '../components/cover_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {
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
                  'ຍິນດີຕ້ອນຮັບ, ${authController.userData['first_name']}',
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
              child: BodySection(),
            ),
          ),
        ],
      ),
    );
  }
}
