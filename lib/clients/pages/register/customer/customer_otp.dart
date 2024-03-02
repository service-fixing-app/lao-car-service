import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_fixing/clients/pages/home_page.dart';

import '../../../../constants.dart';
import '../../../components/registers/customer_otp.dart';

class CustomerOtp extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  CustomerOtp({required this.phoneNumber, required this.verificationId});

  @override
  State<CustomerOtp> createState() => _CustomerOtpState();
}

class _CustomerOtpState extends State<CustomerOtp> {
  // text editing controller
  TextEditingController valueBox1 = TextEditingController();
  TextEditingController valueBox2 = TextEditingController();
  TextEditingController valueBox3 = TextEditingController();
  TextEditingController valueBox4 = TextEditingController();
  TextEditingController valueBox5 = TextEditingController();
  TextEditingController valueBox6 = TextEditingController();
  // otp controller
  // TextEditingController _otpController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
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
                    VerifyOtpCode(
                      controller: valueBox1,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerifyOtpCode(
                      controller: valueBox2,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerifyOtpCode(
                      controller: valueBox3,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerifyOtpCode(
                      controller: valueBox4,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerifyOtpCode(
                      controller: valueBox5,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    VerifyOtpCode(
                      controller: valueBox6,
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
                    onPressed: () async {
                      // Create a PhoneAuthCredential with the code
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode:
                            '${valueBox1.text + valueBox2.text + valueBox3.text + valueBox4.text + valueBox5.text + valueBox6.text}',
                      );

                      // Sign the user in (or link) with the credential
                      await _auth.signInWithCredential(credential);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
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
