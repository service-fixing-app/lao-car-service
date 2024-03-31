
import 'package:flutter/material.dart';
import 'package:service_fixing/constants.dart';

class ServiceRepair extends StatefulWidget {
  const ServiceRepair({super.key});

  @override
  State<ServiceRepair> createState() => _ServiceRepairState();
}

class _ServiceRepairState extends State<ServiceRepair> {
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
              const SizedBox(height: 10.0),
              SizedBox(
                height: 52.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // how to send meassage to repaishop for help
                    // AwesomeNotifications().createNotification(
                    //   content: NotificationContent(
                    //     id: 10, // Unique ID for the notification
                    //     channelKey: 'basic_channel',
                    //     title:
                    //         'New message from customer', // Notification title
                    //     body:
                    //         'A customer needs help with a repair.', // Notification body
                    //   ),
                    // );
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
        ));
  }
}
