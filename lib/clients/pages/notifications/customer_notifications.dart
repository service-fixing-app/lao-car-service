import 'package:flutter/material.dart';
import 'package:service_fixing/constants.dart';

class CustomerNotifications extends StatefulWidget {
  const CustomerNotifications({super.key});

  @override
  State<CustomerNotifications> createState() => _CustomerNotificationsState();
}

class _CustomerNotificationsState extends State<CustomerNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຂໍ້ຄວາມການແຈ້ງເຕື່ອນ',
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
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_default.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_default.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_default.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_default.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            // Add more notification items as needed
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required AssetImage profileImage,
    required String date,
    required String senderName,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 20.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: profileImage,
              radius: 25,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    date,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    senderName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(content),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
