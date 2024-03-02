import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/components/login/verifycode.dart';
import 'package:service_fixing/constants.dart';

class VerifyCode extends StatefulWidget {
  VerifyCode({super.key});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  // text editing controller
  final valueBox = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຢືນຢັນເບີໂທລະສັບ',
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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  'Enter the OTP set to +865 20 7******94 ',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    BoxVerifyCode(
                      controller: valueBox,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Didn\'t receive code ?'),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Resend in 20s',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 500.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/HomePage');
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
        ),
      ),
    );
  }
}
