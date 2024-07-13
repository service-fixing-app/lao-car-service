import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/getRepairshopController.dart';
import 'package:service_fixing/clients/pages/customer/services/service_repair.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideButtonsRepair extends StatelessWidget {
  SlideButtonsRepair({
    Key? key,
    this.latitude,
    this.longitude,
    required this.shopId,
    required this.status,
    this.clatitude,
    this.clongitude,
    required this.markerName,
    required this.score,
    required this.tel,
  }) : super(key: key);

  final double? latitude;
  final double? longitude;
  final String shopId;
  final String status;
  final double? clatitude;
  final double? clongitude;
  final String markerName;
  final String score;
  final String tel;

  @override
  Widget build(BuildContext context) {
    final GetRepairshopController _getRepairshopController = Get.find();
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(
                      'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude&travelmode=driving',
                    );
                    if (await canLaunch(url.toString())) {
                      await launch(url.toString());
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.directions,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ເສັ້ນທາງ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: OutlinedButton(
                  onPressed: () {
                    // print('clatitude : $clatitude');
                    // print('clongitude : $clongitude');
                    // any logic
                    final repairshopData =
                        _getRepairshopController.getOneRepairshop;

                    if (repairshopData['role'] == 'repairshop') {
                      Get.snackbar(
                        'ປະ​ຕິ​ເສດ​ການ​ເຂົ້າ​ເຖິງ',
                        'ທ່ານບໍ່ມີສິດໃນການເຂົ້າເຖິງການບໍລິການນີ້.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white,
                        colorText: Colors.red,
                      );
                    } else if (status == 'ປິດ') {
                      Get.snackbar(
                        'ບໍ່ສາມາດຮ້ອງຂໍໄດ້',
                        'ຮ້ານທີ່ທ່ານຮ້ອງຂໍໄດ້ປິດຮ້ານໃນຄະນະນີ້.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: Colors.white,
                        colorText: Colors.red,
                      );
                    } else {
                      Get.to(() => ServiceRepair(
                            shopId: shopId,
                            shopName: markerName,
                            phoneNumber: tel,
                            clatitude: clatitude,
                            clongitude: clongitude,
                          ));
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.question_mark,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ຮ້ອງຂໍບໍລິການ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: OutlinedButton(
                  onPressed: () {
                    final Uri url = Uri.parse('https://wa.me/856$tel');
                    launchUrl(url);
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/whatsapp.png',
                      fit: BoxFit.cover,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ວອດແອັບ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: OutlinedButton(
                  onPressed: () {
                    FlutterPhoneDirectCaller.callNumber('+856$tel');
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.call,
                      size: 24,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ໂທເບີ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: OutlinedButton(
                  onPressed: () {
                    // any logic
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.grade,
                      size: 24,
                      color: Colors.amber,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ໃຫ້ດາວ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 45.0,
                width: 45.0,
                child: OutlinedButton(
                  onPressed: () {
                    // any logic
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    padding: const EdgeInsets.all(0),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.share,
                      size: 24,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'ແບ່ງປັບ',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
