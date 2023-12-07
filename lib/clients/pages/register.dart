import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
        body: ListView(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
              ),
            ),
          ],
        ),
        Column(
          children: [
            const Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextField(
                      controller: fullnameController,
                      decoration: const InputDecoration(
                        hintText: 'fullname',
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
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
    ));
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
      child: const Text('Sign Up'),
    ),
  );
}
