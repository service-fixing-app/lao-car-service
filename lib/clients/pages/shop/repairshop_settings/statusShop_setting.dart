import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/constants.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class StatuSettings extends StatelessWidget {
  final OpenshopController openshopController = Get.put(OpenshopController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຕັ້ງຄ່າສະຖານະຂອງຮ້ານ',
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
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Obx(() {
          if (openshopController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Get the status from AuthController
            String status = authController.userData['user']['status'];
            bool isOpen = (status == 'ເປີດ');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ສະຖານະຮ້ານ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                      ),
                    ),
                    status == ''
                        ? const Text('No status available')
                        : Switch(
                            value: isOpen,
                            onChanged: (value) async {
                              await openshopController.openshopUpdate(
                                Status(status: value ? 'ເປີດ' : 'ປິດ'),
                              );
                              // Update the authController's status if needed
                              authController.userData['user']['status'] =
                                  value ? 'ເປີດ' : 'ປິດ';
                            },
                            activeColor: primaryColor,
                          ),
                  ],
                ),
                const Divider(height: 2),
              ],
            );
          }
        }),
      ),
    );
  }
}
