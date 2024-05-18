import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/constants.dart';

class ServiceRepair extends StatefulWidget {
  final String shopName;
  final String phoneNumber;
  final double? clatitude;
  final double? clongitude;
  const ServiceRepair({
    Key? key,
    required this.shopName,
    required this.phoneNumber,
    this.clatitude,
    this.clongitude,
  }) : super(key: key);

  @override
  State<ServiceRepair> createState() => _ServiceRepairState();
}

class _ServiceRepairState extends State<ServiceRepair> {
  final AuthController authController = Get.find();
  TextEditingController message = TextEditingController();
  final RequestController requestController = RequestController();

  @override
  Widget build(BuildContext context) {
    // print(userData);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຂໍ້ຄວາມຮ້ອງຂໍບໍລິການ',
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              const Text(
                'ກະລຸນາປ້ອນຂໍ້ຄວາມຮ້ອງຂໍບໍລິການສ້ອມແປງ',
                style: TextStyle(
                  fontFamily: 'phetsarath_ot',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                controller: message,
                keyboardType: TextInputType.multiline,
                maxLines: 10,
                decoration: InputDecoration(
                  labelText: 'ຂໍ້ຄວາມຮ້ອງຂໍ',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 18.0,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 52.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    // logic
                    final senderName = authController.userData['user']
                                ['first_name']
                            ?.toString() ??
                        '';
                    final senderTel =
                        authController.userData['user']['tel']?.toString() ??
                            '';
                    final request = Request(
                      senderName: senderName,
                      senderTel: senderTel,
                      receiverName: widget.shopName,
                      receiverTel: widget.phoneNumber,
                      customerLatitude: widget.clatitude,
                      customerLongitude: widget.clongitude,
                      message: message.text,
                    );
                    // print("request data: $senderName");
                    // print("request data: $senderTel");
                    // print("request data: ${widget.shopName}");
                    // print("request data: ${widget.phoneNumber}");
                    // print("clatitude data: ${widget.clatitude}");
                    // print("clongitude data: ${widget.clongitude}");
                    // print("request data: $message");

                    try {
                      await requestController.requestmessageData(request);
                      if (requestController.isSuccess.value) {
                        // Registration successful
                        print('success added');
                      } else {
                        // Registration failed
                        print(
                            'added error ${requestController.isSuccess.value}');
                      }
                    } catch (error) {
                      // Handle error
                      print(error);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    elevation: 3.0,
                  ),
                  child: const Text(
                    'ສົ່ງຂໍ້ຄວາມ',
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'phetsarath_ot',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
