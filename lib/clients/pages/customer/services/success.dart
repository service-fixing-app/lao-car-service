import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/customer/bottom/bottom_navigation.dart';

class Successs extends StatelessWidget {
  const Successs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/success.png',
                fit: BoxFit.cover,
              ),
              const Text(
                'ສຳເລັດການຮ້ອງຂໍບໍລິການ',
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 3),
              const Text(
                'ກະລຸນາລໍຖ້າຢືນຢັ້ງຮັບຄຳຮ້ອງຂອງທ່ານຈາກຮ້ານດັ່ງກ່າວ!!',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'phetsarath_ot',
                ),
              ),
              const SizedBox(height: 3),
              SizedBox(
                width: 100,
                child: OutlinedButton(
                  style: ButtonStyle(
                    side: MaterialStateProperty.all(
                        const BorderSide(width: 1.5, color: Colors.grey)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  onPressed: ()  async {
                    await Future.delayed( const Duration(seconds: 2));
                    Get.offAll(const CustomBottomBar());
                  },
                  child: const Text(
                    'ກັບຄືນ',
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'phetsarath_ot',
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
