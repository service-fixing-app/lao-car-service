import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../constants.dart';
import '../../../controllers/repairshop/repairshopRegister_controller.dart';
import '../../../models/repairshop_registerModel.dart';

class RepairshopVerify extends StatefulWidget {
  const RepairshopVerify({super.key});

  @override
  State<RepairshopVerify> createState() => _RepairshopVerifyState();
}

class _RepairshopVerifyState extends State<RepairshopVerify> {
  TextEditingController telController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຢືຢັນເບີໂທເພື່ອລົງທະບຽນ',
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
        child: Column(
          children: [
            const Text(
              'ກະລຸນາປ້ອນເບີໂທເພື່ອຢືນຢັນການລົງທະບຽນ',
              style: TextStyle(
                fontFamily: 'phetsarath_ot',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'ເບີໂທລະສັບ',
                  style: TextStyle(
                    fontFamily: 'phetsarath_ot',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black45,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: telController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  prefixText: '+856 20',
                  hintText: '',
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  border: InputBorder.none,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(8)],
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  var repairshop = Repairshop(tel: telController.text);
                  print('Repairshop Object in tell page:');
                  print('First Name: ${repairshop.firstName}');
                  print('Last Name: ${repairshop.lastName}');
                  print('Telephone: ${repairshop.tel}');
                  print('Password: ${repairshop.password}');
                  print('Age: ${repairshop.age}');
                  print('Gender: ${repairshop.gender}');
                  print('Birthdate: ${repairshop.birthdate}');
                  print('Village: ${repairshop.village}');
                  print('District: ${repairshop.district}');
                  print('Province: ${repairshop.province}');
                  print('Profile Image Path: ${repairshop.profileImage}');
                  // Send repairshop data to the controller
                  Get.find<RepairshopController>()
                      .saveRepairshopData(repairshop);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3.0,
                ),
                child: const Text(
                  'ຢືນຢັນ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'phetsarath_ot',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
