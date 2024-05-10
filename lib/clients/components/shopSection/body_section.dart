import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/shop/getRepairshopController.dart';
import 'package:service_fixing/constants.dart';

class BodySection extends StatelessWidget {
  const BodySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GetRepairshopController getRepairshopController =
        Get.put(GetRepairshopController());

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: bgColor,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
        child: Obx(
          () => getRepairshopController.getrepairshopData.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: getRepairshopController.getrepairshopData.length,
                    itemBuilder: (BuildContext context, int index) {
                      final responseData =
                          getRepairshopController.getrepairshopData[index];
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



// Widget _buildListItem() {
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           child: Container(
//             // width: double.infinity,
//             decoration: BoxDecoration(
//               color: const Color(0xFFD6EAF8),
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     Image.network(
//                       'https://p7.hiclipart.com/preview/332/742/376/car-automobile-repair-shop-motor-vehicle-service-hand-painted-garage.jpg',
//                       width: 40,
//                       height: 40,
//                       fit: BoxFit.contain,
//                     ),
//                     const SizedBox(width: 20.0),
//                     const Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Auto Repair car',
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.black54,
//                           ),
//                         ),
//                         Text(
//                           'best shop repair',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.black54,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//                 const Text(
//                   '1st',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: primaryColor,
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ],
//     ),
//   );
// }
