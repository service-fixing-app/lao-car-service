import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_fixing/clients/controllers/shop/openShop_controller.dart';
import 'package:service_fixing/clients/controllers/shop/updateRepairshop_reviewImage.dart';
import 'package:service_fixing/constants.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';

class StatuSettings extends StatefulWidget {
  const StatuSettings({super.key});

  @override
  State<StatuSettings> createState() => _StatuSettingsState();
}

class _StatuSettingsState extends State<StatuSettings> {
  final OpenshopController openshopController = Get.put(OpenshopController());
  final UpdateRepairshopReviewImage updateRepairshopReviewImage =
      Get.put(UpdateRepairshopReviewImage());
  final AuthController authController = Get.find();

  // upload ducoment image
  final ImagePicker _picker = ImagePicker();
  List<File> reviewsShopImageFiles = [];

  Future<void> _getReviewsImages(ImageSource source) async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null) {
      setState(() {
        reviewsShopImageFiles =
            pickedFiles.map((file) => File(file.path)).toList();
      });
    } else {
      print('No document images selected.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຕັ້ງຄ່າສະຖານະຂອງຮ້ານ',
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
        child: Obx(() {
          if (openshopController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // Get the status from AuthController
            String status = authController.userData['user']['status'];
            bool isOpen = (status == 'ເປີດ');

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'ສະຖານະຮ້ານ',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                      ),
                    ),
                    status == ''
                        ? const Text('No status available')
                        : Switch(
                            value: isOpen,
                            onChanged: (value) async {
                              await openshopController.openshopUpdate(
                                Status(status: value ? 'ເປີດ' : 'ປິດ'),
                              );
                              // Update the authController's status if needed
                              authController.userData['user']['status'] =
                                  value ? 'ເປີດ' : 'ປິດ';
                            },
                            activeColor: primaryColor,
                          ),
                  ],
                ),
                const Divider(height: 2),
                const SizedBox(height: 20),
                const Text(
                  'ການອັບຮູບພາບລີວິວໝ້າຮ້ານ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _getReviewsImages(ImageSource.gallery),
                      child: const Text(
                        'ເລືອກຮູບພາບ',
                        style: TextStyle(fontFamily: 'phetsarath_ot'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () async {
                        if (reviewsShopImageFiles.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('ແຈ້ງເຕືອນ'),
                                content: const Text('ກະລຸນາເລືອກຮູບພາບ!!'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                          return; // Do not proceed further
                        } else {
                          final reviewsImage = ReviewsImage(
                            reviewsShopImageFiles: reviewsShopImageFiles,
                          );
                          try {
                            await updateRepairshopReviewImage
                                .addShopReviewImage(reviewsImage);
                            print('click me');
                          } catch (error) {
                            print('error $error');
                          }
                        }
                      },
                      child: updateRepairshopReviewImage.isLoading.value
                          ? const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(width: 5),
                                CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ],
                            )
                          : const Text(
                              'ອັບເດດຮູບພາບໃນຮ້ານ',
                              style: TextStyle(fontFamily: 'phetsarath_ot'),
                            ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                reviewsShopImageFiles.isNotEmpty
                    ? Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4.0,
                            mainAxisSpacing: 4.0,
                          ),
                          itemCount: reviewsShopImageFiles.length,
                          itemBuilder: (context, index) {
                            return Image.file(reviewsShopImageFiles[index],
                                fit: BoxFit.cover);
                          },
                        ),
                      )
                    : const Center(
                        child: Text(
                          'ຍັງບໍ່ມີຮູບພາບທີ່ເລືອກ.',
                          style: TextStyle(
                            fontFamily: 'phetsarath_ot',
                          ),
                        ),
                      ),
                const SizedBox(height: 10),
                const Divider(height: 2),
              ],
            );
          }
        }),
      ),
    );
  }
}
