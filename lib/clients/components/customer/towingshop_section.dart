import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/getTowingshopController.dart';
import 'package:service_fixing/clients/pages/map/towingshop_map.dart';
import 'package:service_fixing/constants.dart';
import 'package:shimmer/shimmer.dart';

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
          () {
            if (getTowingshopController.isLoading.value) {
              // return buildShimmerLoading();
              return const Center(child: Text('loading...'));
            } else if (getTowingshopController.getTowingshopData.isEmpty) {
              return const Center(
                child: Text('ຍັງບໍ່ມີຂໍ້ມູນຮ້ານ'),
              );
            } else {
              final filteredData = getTowingshopController.getTowingshopData
                  .where((shop) => shop['permission_status'] == 'true')
                  .toList();
              // Show data
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: filteredData.length,
                  itemBuilder: (BuildContext context, int index) {
                    final responseData = filteredData[index];
                    return _buildShopItem(
                      shopName: responseData['shop_name'],
                      managerName: responseData['manager_name'],
                      tel: responseData['tel'].toString(),
                      typeService: responseData['type_service'],
                      profileImage: responseData['profile_image'],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildShopItem({
    required String shopName,
    required String managerName,
    required String tel,
    required String typeService,
    String? profileImage,
  }) {
    final ImageProvider imageProvider = (profileImage != null &&
            profileImage.isNotEmpty)
        ? NetworkImage(profileImage)
        : const AssetImage('assets/images/default-white.png') as ImageProvider;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            backgroundImage: imageProvider,
            radius: 35,
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
            Get.to(() => TowingshopMap());
          },
        ),
      ),
    );
  }

  // Widget buildShimmerLoading() {
  //   return Shimmer.fromColors(
  //     baseColor: Colors.grey[300]!,
  //     highlightColor: Colors.grey[100]!,
  //     child: ListView.builder(
  //       padding: EdgeInsets.zero,
  //       itemCount: 5,
  //       itemBuilder: (BuildContext context, int index) {
  //         return ListTile(
  //           leading: const CircleAvatar(
  //             backgroundColor: Colors.white,
  //             radius: 25,
  //           ),
  //           title: Container(
  //             height: 10.0,
  //             color: Colors.white,
  //           ),
  //           subtitle: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Container(
  //                 margin: const EdgeInsets.symmetric(vertical: 5.0),
  //                 height: 10.0,
  //                 color: Colors.white,
  //               ),
  //               Container(
  //                 height: 10.0,
  //                 color: Colors.white,
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
}
