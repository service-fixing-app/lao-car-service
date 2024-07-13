import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/logout/logout.dart';
import 'package:service_fixing/clients/controllers/shop/getRepairshopController.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/information_setting.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/password_setting.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/report_repairshop.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/shop_location.dart';
import 'package:service_fixing/clients/pages/shop/repairshop_settings/statusShop_setting.dart';
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
                                    Get.to(() => const InformationSetting());
                                  },
                                ),
                                // _buildSettingRow(
                                //   icon: Icons.lock_person,
                                //   text: 'ຂໍ້ມູນລະຫັດຜ່ານ ແລະ ເບີຕິດຕໍ່',
                                //   onTap: () {
                                //     Get.to(() => const PasswordSetting());
                                //   },
                                // ),
                                _buildSettingRow(
                                  icon: Icons.settings,
                                  text: 'ຕັ້ງສະຖານະ ແລະ ຮູບພາບຮ້ານ',
                                  onTap: () {
                                    Get.to(() => const StatuSettings());
                                  },
                                ),
                                _buildShopLocation(
                                  icon: Icons.location_on,
                                  text: 'ກຳນົດທີ່ຢູ່ຮ້ານ',
                                  onTap: () {
                                    Get.to(() => const ShopLocation());
                                  },
                                ),
                                _buildShopLocation(
                                  icon: Icons.data_saver_off,
                                  text: 'ລາຍງານ',
                                  onTap: () {
                                    Get.to(() => const ReportRepairshop());
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
    final GetRepairshopController _getRepairshopController =
        Get.put(GetRepairshopController());
    final repairshopData = _getRepairshopController.getOneRepairshop;
    return Row(
      children: [
        const SizedBox(width: 10),
        // CircleAvatar(
        //   radius: 40,
        //   backgroundImage: NetworkImage('${repairshopData['profile_image']}'),
        // ),
        CircleAvatar(
          backgroundColor: Colors.blue,
          radius: 40,
          backgroundImage: (repairshopData['profile_image'] != null &&
                  (repairshopData['profile_image'] as String).isNotEmpty)
              ? NetworkImage(repairshopData['profile_image'] as String)
              : const AssetImage('assets/images/default-white.png')
                  as ImageProvider,
        ),

        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10.0,
            ),
            Text(
              '${repairshopData['manager_name']}',
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
              '+856 ${repairshopData['tel']}',
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

  Widget _buildShopLocation({
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
        ],
      ),
    );
  }
}
