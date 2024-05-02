import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/constants.dart';

class ServiceRepair extends StatefulWidget {
  const ServiceRepair({super.key});

  @override
  State<ServiceRepair> createState() => _ServiceRepairState();
}

class _ServiceRepairState extends State<ServiceRepair> {
  final AuthController authController = Get.find();
  TextEditingController senderName = TextEditingController();
  TextEditingController senderTel = TextEditingController();
  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverTel = TextEditingController();
  TextEditingController message = TextEditingController();
  // TextEditingController _status = TextEditingController();

  final RequestController requestController = RequestController();

  @override
  void initState() {
    super.initState();
    senderTel.text = authController.userData['user']['tel'] != null
        ? authController.userData['user']['tel'].toString()
        : '';
    senderName.text = authController.userData['user']['first_name'] != null
        ? authController.userData['user']['first_name'].toString()
        : '';
    print(" sender name : $senderTel");
    print(" sender name : $senderName");
  }

  @override
  Widget build(BuildContext context) {
    final userData = authController.userData['user'];
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
                // controller: userData['first_name'] != null
                //     ? TextEditingController(text: userData['first_name'])
                //     : senderName,
                controller: senderName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'ຊື່ຜູ້ຮ້ອງຂໍບໍລິການ',
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
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: senderTel,
                // controller: userData['tel'] != null
                //     ? TextEditingController(text: userData['tel'].toString())
                //     : senderTel,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'ເບີໂທຜູ້ຮ້ອງຂໍບໍລິການ',
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
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: receiverName,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'ຊື່ຮ້ານສ້ອມແປງ',
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
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: receiverTel,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: 'ເບີໂທຮ້ານສ້ອມແປງ',
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
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                controller: message,
                keyboardType: TextInputType.multiline,
                maxLines: null,
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
                    final request = Request(
                      senderName: senderName.text,
                      senderTel: senderTel.text,
                      receiverName: receiverName.text,
                      receiverTel: receiverTel.text,
                      message: message.text,
                    );

                    // print("request data: $senderName");
                    // print("request data: $senderTel");
                    // print("request data: $receiverName");
                    // print("request data: $receiverTel");
                    // print("request data: $message");

                    try {
                      await requestController.requestmessageData(request);
                      if (requestController.isSuccess.value) {
                        // Registration successful
                        // OneSignal.shared.addTrigger(key, value);
                        print('success added');
                      } else {
                        // Registration failed
                        print('added error');
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
