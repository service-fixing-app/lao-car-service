import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/account_setting/user_profile.dart';

import '../../constants.dart';
import '../components/account_setting/user_info.dart';

class AccountSetting extends StatefulWidget {
  const AccountSetting({super.key});

  @override
  State<AccountSetting> createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'Account Settings',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'phetsarath_ot',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const UserProfile(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      // const UserName(),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      // const PhoneNumber(),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      // const Email(),
                      // const SizedBox(
                      //   height: 16.0,
                      // ),
                      // const Password(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        color: primaryColor,
                        child: InkWell(
                          onTap: () {},
                          child: const Text(
                            'Logout',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
