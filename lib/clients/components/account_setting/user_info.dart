import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../pages/register.dart';

class BuildField extends StatelessWidget {
  final String data;
  final AuthController authController = Get.find();

  BuildField({
    Key? key,
    required this.data,
  }) : super(key: key);

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
      child: Text(
        '$data',
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
    );
  }
}

// class UserName extends StatelessWidget {
//   const UserName({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return BuildField(
//       // display fullname
//       data: authController.userData['fullname'], 
//     );
//   }
// }

// class PhoneNumber extends StatelessWidget {
//   const PhoneNumber({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return BuildField(
//       // display phone number
//       data: authController.userData['phone'],
//     );
//   }
// }

// class Email extends StatelessWidget {
//   const Email({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return BuildField(
//       // display email
//       data: authController.userData['email'],
//     );
//   }
// }

// class Password extends StatelessWidget {
//   const Password({Key? key});

//   @override
//   Widget build(BuildContext context) {
//     return BuildField(
//       // display password
//       data: authController.userData['password'],
//     );
//   }
// }
