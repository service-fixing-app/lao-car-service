import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/repairshopRequestion_report.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/repairshopScore_report.dart';
import 'package:service_fixing/constants.dart';

class ReportRepairshop extends StatefulWidget {
  const ReportRepairshop({super.key});

  @override
  State<ReportRepairshop> createState() => _ReportRepairshopState();
}

class _ReportRepairshopState extends State<ReportRepairshop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ລາຍງານ',
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const RepairshopScoreReport());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/star.png',
                          width: 30,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          'ລາຍງານຄະແນນຮ້ານສ້ອມແປງ',
                          style: TextStyle(
                            fontFamily: 'phetsarath_ot',
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(() => const RepairshopRequestReport());
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/request.png',
                          width: 30,
                          color: Colors.black54,
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        const Text(
                          'ລາຍງານຮ້ອງຂໍການບໍລິການສ້ອມແປງລົດ',
                          style: TextStyle(
                            fontFamily: 'phetsarath_ot',
                            fontWeight: FontWeight.w500,
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
