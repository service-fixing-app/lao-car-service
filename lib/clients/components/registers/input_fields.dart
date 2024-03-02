import 'package:flutter/material.dart';

import '../../pages/register.dart';

class BuildInput extends StatelessWidget {
  const BuildInput({
    super.key,
    required this.prefixIcon,
    required this.hintText,
    required this.controller,
  });

  final IconData prefixIcon;
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
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
          prefixIcon: Icon(prefixIcon),
          hintText: hintText,
          hintStyle: const TextStyle(
            fontFamily: 'phetsarath_ot',
            fontSize: 18,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
        ),
      ),
    );
  }
}

class UserNameInput extends StatelessWidget {
  const UserNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildInput(
      prefixIcon: Icons.person,
      hintText: 'ຜູ້ໃຊ້',
      controller: fullnameController,
    );
  }
}

class PhoneNumberInput extends StatelessWidget {
  const PhoneNumberInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildInput(
      prefixIcon: Icons.call,
      hintText: 'ເບີໂທ',
      controller: phoneController,
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildInput(
      prefixIcon: Icons.email,
      hintText: 'ອິເມວ',
      controller: emailController,
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BuildInput(
      prefixIcon: Icons.lock,
      hintText: 'ລະຫັດຜ່ານ',
      controller: passwordController,
    );
  }
}
