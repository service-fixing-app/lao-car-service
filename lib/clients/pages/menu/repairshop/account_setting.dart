import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/menu/customer/contact_setting.dart';
import 'package:service_fixing/clients/pages/menu/customer/information_setting.dart';
import 'package:service_fixing/clients/pages/menu/customer/password_setting.dart';
import 'package:service_fixing/constants.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  static const double coverHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildCoverImage(),
            ],
          ),
          _buildPositionedContainer(),
          Column(
            children: [
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 180.0,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print('click me 1');
                                      Get.to(const InformationSetting());
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'ຂໍ້ມູນພື້ນຖານ',
                                          style: TextStyle(
                                            fontFamily: 'phetsarath_ot',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print('click me 2');
                                      Get.to(const PasswordSetting());
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.lock_person,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'ຂໍ້ມູນລະຫັດຜ່ານ ແລະ ເບີຕິດຕໍ່',
                                          style: TextStyle(
                                            fontFamily: 'phetsarath_ot',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      print('click me 3');
                                      Get.to(const ContactSetting());
                                    },
                                    child: const Row(
                                      children: [
                                        Icon(
                                          Icons.contact_phone_rounded,
                                          color: Colors.black54,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          'ຂໍ້ມູນການຕິດຕໍ່',
                                          style: TextStyle(
                                            fontFamily: 'phetsarath_ot',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black54,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Colors.black54,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCoverImage() {
    return Container(
      height: coverHeight,
      width: double.infinity,
      child: Image.asset(
        'assets/images/acc.png',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPositionedContainer() {
    return Positioned(
      top: coverHeight / 1.5,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 100.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLocationRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationRow() {
    return const Row(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: AssetImage(
            'assets/images/user_profile.gif',
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Khamsy her',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '+8562077665494',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 16,
              ),
            )
          ],
        )
      ],
    );
  }
}
