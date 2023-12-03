import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _hidePassword = true;

  void _handleLogin() {
    final email = emailController.text;
    final password = passwordController.text;
    authController.login(email, password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Color(int.parse('0xFFD2D9E1')),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/service-car.jpg',
                        fit: BoxFit.cover,
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            const Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 30.0),
                            _buildTextField('Email', emailController),
                            const SizedBox(height: 20.0),
                            _buildPasswordTextField(),
                            const SizedBox(height: 15.0),
                            _buildForgotPasswordText(),
                            const SizedBox(height: 30.0),
                            _buildLoginButton(),
                            const SizedBox(height: 30.0),
                            _buildDividerWithText(),
                            const SizedBox(height: 30.0),
                            _buildSocialMediaIcons(),
                            const SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 195, 194, 194),
            offset: Offset(0, 2),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 195, 194, 194),
            offset: Offset(0, 2),
            blurRadius: 3.0,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: TextField(
        obscureText: _hidePassword,
        controller: passwordController,
        decoration: InputDecoration(
          hintText: 'Password',
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          suffixIcon: Padding(
            padding: const EdgeInsets.all(8),
            child: IconButton(
              onPressed: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              icon: _hidePassword
                  ? const Icon(Icons.visibility_off)
                  : const Icon(Icons.visibility),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 50.0,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _handleLogin,
        style: ElevatedButton.styleFrom(
          primary: Colors.orange.shade800,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 3.0,
        ),
        child: const Text('Login'),
      ),
    );
  }

  Widget _buildDividerWithText() {
    return const Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          child: Text(
            'Or continue with',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialMediaIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Not a member?'),
        const SizedBox(width: 5.0),
        InkWell(
          onTap: () {
            Get.to(
              () => const RegisterPage(),
              transition: Transition.rightToLeft,
              curve: Curves.easeInOut,
              duration: const Duration(milliseconds: 500),
            );
          },
          child: const Text(
            'Register Now',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
