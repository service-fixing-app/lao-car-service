import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/shop/shopLocation_controller.dart';
import 'package:service_fixing/constants.dart';

class ShopLocation extends StatefulWidget {
  const ShopLocation({super.key});

  @override
  State<ShopLocation> createState() => _ShopLocationState();
}

class _ShopLocationState extends State<ShopLocation> {
  final ShopLocationController shopLocationController =
      Get.put(ShopLocationController());
  final AuthController authController = Get.find();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  bool isButtonVisible = false;
  @override
  void initState() {
    super.initState();
    fetchShopLocationByShopName();

    latitude.text = shopLocationController.specificLocation.value.latitude != ""
        ? shopLocationController.specificLocation.value.latitude.toString()
        : '';
    longitude.text =
        shopLocationController.specificLocation.value.longitude != ""
            ? shopLocationController.specificLocation.value.longitude.toString()
            : '';
    // print(" latitude : $latitude");
    // print(" longitude : $longitude");
    if (latitude.text.isNotEmpty && longitude.text.isNotEmpty) {
      setState(() {
        isButtonVisible = false;
      });
    } else {
      setState(() {
        isButtonVisible = true;
      });
    }
  }

  void fetchShopLocationByShopName() {
    final userData = authController.userData['user'];
    final String shopName = userData['shop_name'];
    shopLocationController.fetchShopLocationsByShopName(shopName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຕັ້ງຄ່າທີ່ຢູ່ຂອງຮ້ານ',
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
        padding: const EdgeInsets.all(15.0),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ທີ່ຢູ່ຂອງຮ້ານ',
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'phetsarath_ot',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: latitude,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ເສັ້ນຂະໜານ',
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
              const SizedBox(height: 20),
              TextField(
                controller: longitude,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'ເສັ້ນແວງ',
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
                height: 10,
              ),
              Visibility(
                visible: isButtonVisible,
                child: SizedBox(
                  height: 52.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      final location = ShopNewlocation(
                        latitude: latitude.text,
                        longitude: longitude.text,
                      );

                      try {
                        await shopLocationController.shopLocationData(location);
                      } catch (error) {
                        // Handle error
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                    ),
                    child: const Text(
                      'ບັນທືຶກ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
