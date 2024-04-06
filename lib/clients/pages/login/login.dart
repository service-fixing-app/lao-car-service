import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../constants.dart';
import '../../controllers/login/auth_controller.dart';
import '../register/register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // define all varrible
  final AuthController authController = Get.put(AuthController());
  final TextEditingController telController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _hidePassword = true;
  bool _isLoading = false;

  void _handleLogin() async {
    setState(() {
      _isLoading = true;
    });
    final tel = telController.text;
    final password = passwordController.text;
    await authController.login(tel, password);
    setState(() {
      _isLoading = false;
    });
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
                    TextField(
                      controller: telController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'ເບີໂທລະສັບ',
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
                          horizontal: 10.0,
                          vertical: 20.0,
                        ),
                        prefixText: '+856 ',
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Colors.grey,
                        ),
                        focusColor: Colors.black87,
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    // password
                    const SizedBox(height: 20.0),
                    TextField(
                      obscureText: _hidePassword,
                      controller: passwordController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'ລະຫັດຜ່ານ',
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
                          horizontal: 10.0,
                          vertical: 15.0,
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.grey,
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(6),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                _hidePassword = !_hidePassword;
                              });
                            },
                            icon: _hidePassword
                                ? const Icon(Icons.visibility_off)
                                : const Icon(Icons.visibility),
                            color: Colors.grey,
                          ),
                        ),
                        focusColor: Colors.black87,
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey, width: 2.0),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(8),
                      ],
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
                        child: _isLoading
                            ? const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Loading...',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(width: 5),
                                  CircularProgressIndicator(
                                      color: Colors.white),
                                ],
                              ) // Show loading indicator if _isLoading is true
                            : const Text(
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
