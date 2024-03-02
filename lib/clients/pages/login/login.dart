import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../controllers/auth_controller.dart';
import '../register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // define all varrible
  final AuthController authController = AuthController();
  final TextEditingController telController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _handleLogin() {
    final tel = telController.text;
    final password = passwordController.text;
    authController.login(tel, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10.0),
                    const Text(
                      'ເຂົ້າສູ່ລະບົບ',
                      style: TextStyle(
                        fontFamily: 'phetsarath_ot',
                        fontSize: 25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    const Text(
                      'ກະລຸນາປ້ອນເບີໂທເພື່ອຢືນຢັນເຂົ້າສູ່ລະບົບ',
                      style: TextStyle(
                        fontFamily: 'phetsarath_ot',
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    // phone number
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
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          prefixText: '+856 20 ',
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 10.0),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(12)],
                      ),
                    ),
                    // password
                    const SizedBox(height: 10.0),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'ລະຫັດຜ່ານ',
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
                        controller: passwordController,
                        style: const TextStyle(
                          fontSize: 18.0,
                        ),
                        textAlignVertical: TextAlignVertical.center,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          suffixIcon: Icon(Icons.remove_red_eye_rounded),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 8.0,
                          ),
                          border: InputBorder.none,
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(8)],
                      ),
                    ),

                    const SizedBox(
                      height: 30.0,
                    ),
                    // login
                    SizedBox(
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3.0,
                        ),
                        child: const Text(
                          'ເຂົ້າສູ່ລະບົບ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'phetsarath_ot',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    // register member
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'ຍັງບໍ່ມີບັນຊີຜູ້ໃຊ້?',
                          style: TextStyle(
                            fontFamily: 'phetsarath_ot',
                          ),
                        ),
                        const SizedBox(width: 5.0),
                        InkWell(
                          onTap: () {
                            Get.to(
                              () => const Register(),
                              transition: Transition.downToUp,
                              curve: Curves.easeInOut,
                              duration: const Duration(milliseconds: 500),
                            );
                          },
                          child: const Text(
                            'ລົງທະບຽນຜູ້ໃຊ້',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'phetsarath_ot',
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
