import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/constants.dart';
import '../components/registers/input_fields.dart';
import '../components/registers/user_profile.dart';
import '../controllers/register_controller.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

final RegisterController authController = RegisterController();
final TextEditingController fullnameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController phoneController = TextEditingController();

void _handleSignup() {
  final username = fullnameController.text;
  final email = emailController.text;
  final password = passwordController.text;
  authController.signup(username, email, password);
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text(
          'ລົງທະບຽນຜູ້ໃຊ້',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: 'phetsarath_ot',
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20.0,
              ),
              const UserProfile(),
              SizedBox(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      const UserNameInput(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const PhoneNumberInput(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const EmailInput(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      const PasswordInput(),
                      const SizedBox(
                        height: 30.0,
                      ),
                      _buildSignUpButton(),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

Widget _buildSignUpButton() {
  return Container(
    height: 50.0,
    width: double.infinity,
    child: ElevatedButton(
      onPressed: _handleSignup,
      style: ElevatedButton.styleFrom(
        primary: Colors.orange.shade800,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        elevation: 3.0,
      ),
      child: const Text(
        'ລົງທະບຽນ',
        style: TextStyle(
          fontFamily: 'phetsarath_ot',
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
