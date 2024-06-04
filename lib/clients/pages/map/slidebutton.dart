import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/customer/services/service_repair.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideButtons extends StatelessWidget {
  const SlideButtons({
    super.key,
    required this.clatitude,
    required this.clongitude,
    required this.markerName,
    required this.tel,
    required this.score,
    required this.shopId,
  });
  final String markerName;
  final String tel;
  final String score;
  final double? clatitude;
  final double? clongitude;
  final String shopId;

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    // any logic
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
                    Get.to(() => ServiceRepair(
                          shopId: shopId,
                          shopName: markerName,
                          phoneNumber: tel,
                          clatitude: clatitude,
                          clongitude: clongitude,
                        ));
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
