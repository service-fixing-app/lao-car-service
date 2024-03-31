import 'package:flutter/material.dart';
import 'package:service_fixing/constants.dart';

class HistoryPages extends StatefulWidget {
  const HistoryPages({super.key});

  @override
  State<HistoryPages> createState() => _HistoryPagesState();
}

class _HistoryPagesState extends State<HistoryPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ປະຫັວດ',
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
              profileImage: const AssetImage('assets/images/man.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/man.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_default.png'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content: 'Lorem ipsum dolor sit ametconsectetur adipiscing elit.',
            ),
            _buildNotificationItem(
              profileImage: const AssetImage('assets/images/user_profile.gif'),
              date: '25/20/2024',
              senderName: 'John Doe',
              content:
                  'Lorem ipsum dolor sit ametconsectetur Lorem ipsum dolor sit ametconsectetur adipiscing elit.',
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
      padding: const EdgeInsets.all(3.0),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 18.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: profileImage,
              radius: 25,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        senderName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        date,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4.0,
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
