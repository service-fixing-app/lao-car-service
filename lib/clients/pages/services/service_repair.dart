import 'package:flutter/material.dart';
import 'package:service_fixing/clients/controllers/requestion/request_controller.dart';
import 'package:service_fixing/constants.dart';

class ServiceRepair extends StatefulWidget {
  const ServiceRepair({super.key});

  @override
  State<ServiceRepair> createState() => _ServiceRepairState();
}

class _ServiceRepairState extends State<ServiceRepair> {
  TextEditingController _senderName = TextEditingController();
  TextEditingController _senderTel = TextEditingController();
  TextEditingController _receiverName = TextEditingController();
  TextEditingController _receiverTel = TextEditingController();
  TextEditingController _message = TextEditingController();
  // TextEditingController _status = TextEditingController();

  final RequestController requestController = RequestController();
  @override
  Widget build(BuildContext context) {
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
                  controller: _senderName,
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
                  controller: _senderTel,
                  keyboardType: TextInputType.name,
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
                  controller: _receiverName,
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
                  controller: _receiverTel,
                  keyboardType: TextInputType.name,
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
                  controller: _message,
                  keyboardType: TextInputType.multiline, // Change keyboardType
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
                        senderName: _senderName.text,
                        senderTel: _senderTel.text,
                        receiverName: _receiverName.text,
                        receiverTel: _receiverTel.text,
                        message: _message.text,
                      );

                      try {
                        await requestController.requestmessageData(request);
                        if (requestController.isSuccess.value) {
                          // Registration successful
                          print('success added');
                        } else {
                          // Registration failed
                          print('added error');
                        }
                      } catch (error) {
                        // Handle error
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
              ],
            ),
          ),
        ));
  }
}
