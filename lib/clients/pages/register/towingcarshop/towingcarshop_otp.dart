import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/towingcarshop/towingcarshopVerifieOtp_controller.dart';

import '../../../../constants.dart';
import '../../../components/registers/repairshop_otp.dart';

class TowingcarshopOtp extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;

  TowingcarshopOtp({required this.phoneNumber, required this.verificationId});

  @override
  State<TowingcarshopOtp> createState() => _TowingcarshopOtpState();
}

class _TowingcarshopOtpState extends State<TowingcarshopOtp> {
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
  final OtpTowingcarshopController otpTowingcarController =
      Get.put(OtpTowingcarshopController());
  // error message
  String? errorMessage;
  //
  int _countdownSeconds = 20; // Total seconds for the countdown
  late Timer _timer;

  void resendCode() {
    // Add your code to resend the verification code here
    // Reset the countdown timer
    _countdownSeconds = 20;
    startTimer(); // Start the timer again
  }

  // Method to start the timer
  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (timer) {
        setState(() {
          if (_countdownSeconds == 0) {
            timer.cancel(); // Cancel the timer when countdown reaches 0
          } else {
            _countdownSeconds--; // Decrease the countdown seconds
          }
        });
      },
    );
  }

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
                Text(
                  'Enter the OTP set to ${widget.phoneNumber} ',
                  style: const TextStyle(fontSize: 18.0),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    VerifyOtpCode(
                      controller: valueBox1,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    VerifyOtpCode(
                      controller: valueBox2,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    VerifyOtpCode(
                      controller: valueBox3,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    VerifyOtpCode(
                      controller: valueBox4,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    VerifyOtpCode(
                      controller: valueBox5,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                    VerifyOtpCode(
                      controller: valueBox6,
                    ),
                    // const SizedBox(
                    //   width: 10.0,
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive code ? Resend in $_countdownSeconds s',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed:
                        _countdownSeconds == 0 ? () => resendCode() : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                    ),
                    child: const Text(
                      'Resend Code',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'phetsarath_ot',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      String otp =
                          '${valueBox1.text}${valueBox2.text}${valueBox3.text}${valueBox4.text}${valueBox5.text}${valueBox6.text}';
                      bool isVerified = false;
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                          verificationId: widget.verificationId,
                          smsCode: otp,
                        );
                        await _auth.signInWithCredential(credential);
                        isVerified = true;
                        // send is verified to controller
                        otpTowingcarController.isVerified.value = isVerified;
                      } catch (e) {
                        setState(() {
                          errorMessage = 'Invalid OTP code. Please try again.';
                        });
                      }
                      // send is tel to controller
                      otpTowingcarController.tel.value =
                          widget.phoneNumber.substring(4);
                      Get.back();
                      // Get.to(
                      //   CustomerVerify(
                      //     tel: widget.phoneNumber.substring(4),
                      //     isVerified: isVerified,
                      //   ),
                      // );
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
