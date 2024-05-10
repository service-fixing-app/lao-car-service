import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/getTowingshopController.dart';
import 'package:service_fixing/constants.dart';

class TowingshopSection extends StatelessWidget {
  const TowingshopSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetTowingshopController getTowingshopController =
        Get.put(GetTowingshopController());

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Obx(
          () => getTowingshopController.getTowingshopData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getTowingshopController.getTowingshopData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final responseData =
                          getTowingshopController.getTowingshopData[index];
                      return _buildShopItem(
                        shopName: responseData['shop_name'],
                        managerName: responseData['manager_name'],
                        tel: responseData['tel'].toString(),
                        typeService: responseData['type_service'],
                        profileImage: NetworkImage(
                          responseData['profile_image'],
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildShopItem({
    required String shopName,
    required String managerName,
    required String tel,
    required String typeService,
    required ImageProvider profileImage,
  }) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: profileImage,
            radius: 25,
          ),
          title: Text('ຮ້ານ: $shopName'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Tel: $tel'),
              Text('ປະເພດບໍລິການ: $typeService'),
            ],
          ),
          onTap: () {
            // print('Click object');
          },
        ),
      ),
    );
  }
}
