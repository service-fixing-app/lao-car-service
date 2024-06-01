import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/logout/logout.dart';
import 'package:service_fixing/clients/pages/customer/settings/information_setting.dart';
import 'package:service_fixing/clients/pages/customer/settings/password_setting.dart';
import 'package:service_fixing/constants.dart';

class AccountSetting extends StatelessWidget {
  const AccountSetting({Key? key}) : super(key: key);

  static const double coverHeight = 180.0;

  @override
  Widget build(BuildContext context) {
    final LogoutController logoutController = LogoutController();
    final AuthController authController = Get.find();

    return Scaffold(
      backgroundColor: bgColor,
      body: Obx(() {
        if (authController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
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
                          height: 200.0,
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
                                _buildSettingRow(
                                  icon: Icons.person,
                                  text: 'ຂໍ້ມູນພື້ນຖານ',
                                  onTap: () {
                                    Get.to(const InformationSetting());
                                  },
                                ),
                                _buildSettingRow(
                                  icon: Icons.lock_person_rounded,
                                  text: 'ຂໍ້ມູນລະຫັດຜ່ານ ແລະ ເບີຕິດຕໍ່',
                                  onTap: () {
                                    Get.to(const PasswordSetting());
                                  },
                                ),
                                _buildLogout(
                                  icon: Icons.logout_rounded,
                                  text: 'ອອກຈາກລະບົບ',
                                  onTap: () async {
                                    // logout logic
                                    await logoutController.logout();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
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
                          // child: const Padding(
                          //   padding: EdgeInsets.all(10.0),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.admin_panel_settings_rounded,
                          //         color: primaryColor,
                          //       ),
                          //       SizedBox(width: 10),
                          //       Text(
                          //         'Admin  02077665494',
                          //         style: TextStyle(
                          //           color: primaryColor,
                          //           fontSize: 18,
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        }
      }),
    );
  }

  Widget _buildCoverImage() {
    return SizedBox(
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
    final AuthController authController = Get.find();
    final userData = authController.userData['user'];
    return Row(
      children: [
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage('${userData['profile_image']}'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '${userData['first_name']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '+856 ${userData['tel']}',
              style: const TextStyle(
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

  Widget _buildSettingRow({
    required IconData icon,
    required String text,
    required void Function() onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black54,
                  size: 30,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 18,
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
    );
  }

  Widget _buildLogout({
    required IconData icon,
    required String text,
    required void Function() onTap,
  }) {
    // final LogoutController logoutController = Get.find();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.black54,
                  size: 30,
                ),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          // Obx(() {
          //   if (logoutController.isLoading.value) {
          //     return const SizedBox(
          //       width: 20.0,
          //       height: 20.0,
          //       child: CircularProgressIndicator(),
          //     );
          //   } else {
          //     return const SizedBox.shrink();
          //   }
          // }),
        ],
      ),
    );
  }
}
