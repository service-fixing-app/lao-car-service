import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
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
        const Column(
          children: [
            Center(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Username',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Password',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Email',
                      ),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Phone',
                      ),
                    )
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
