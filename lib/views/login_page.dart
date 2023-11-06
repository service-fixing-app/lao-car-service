import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // used getx state is for login
  AuthController authController = AuthController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _seepass = true;
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
            // Container(
            //   height: 300.0,
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //       colors: [Colors.orange.shade900, Colors.orange.shade700],
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //     ),
            //     borderRadius: const BorderRadius.only(
            //       bottomLeft: Radius.circular(90.0),
            //     ),
            //   ),
            //   child: Image.asset(
            //     'assets/images/icon/app_icon.png',
            //     width: 0.1,
            //     height: 0.1,
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  const SizedBox(
                    height: 100.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/icon/app_icon.png',
                        width: 100,
                        height: 100,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
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
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                              left: 20,
                              top: 20,
                              bottom: 20,
                              right: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
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
                          obscureText: _seepass,
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.only(
                              left: 20,
                              top: 20,
                              bottom: 20,
                              right: 20,
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8),
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _seepass = !_seepass;
                                  });
                                },
                                icon: _seepass
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Forgot Password?',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Container(
                        height: 50.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            // Login method
                            print("Email: " + emailController.text);
                            print("Password: " + passwordController.text);
                            _handleLogin();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.orange.shade800,
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    30.0), // Set the border-radius
                              ),
                            ),
                            elevation: MaterialStateProperty.all<double>(
                                3.0), // Set the elevation (shadow)
                          ),
                          child: const Text('Login'),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  // Google and facebook icons
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Not a member?'),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Register Now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
