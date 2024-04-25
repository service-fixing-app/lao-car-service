import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/constants.dart';

class StatuSettings extends StatelessWidget {
  final OpenshopController openshopController = Get.put(OpenshopController());

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
        padding: const EdgeInsets.all(10.0),
        child: Column(
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
                Obx(
                  () => Switch(
                    value: openshopController.isOpen.value,
                    onChanged: (value) {
                      openshopController.isOpen.value = value;
                    },
                    activeColor: primaryColor,
                  ),
                ),
                // GetBuilder<OpenshopController>(
                //   builder: (_) => Switch(
                //     value: openshopController.isSwitcheded,
                //     onChanged: (value) {
                //       openshopController.changeSwitchState(value);
                //     },
                //     activeColor: primaryColor,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
