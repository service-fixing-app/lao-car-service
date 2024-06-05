import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/controllers/customer/verifieotp_controller.dart';
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
  final OtpController otpController = Get.put(OtpController());
  // error message
  String? errorMessage;
  //
  Timer? _timer;
  int _start = 30;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
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
                  'ກະລຸນາປ້ອນOTPໃຫ້${widget.phoneNumber} ',
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
                    VerifyOtpCode(
                      controller: valueBox2,
                    ),
                    VerifyOtpCode(
                      controller: valueBox3,
                    ),
                    VerifyOtpCode(
                      controller: valueBox4,
                    ),
                    VerifyOtpCode(
                      controller: valueBox5,
                    ),
                    VerifyOtpCode(
                      controller: valueBox6,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 60.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Didn\'t receive code ? Resend in $_start s',
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
                    onPressed: _start == 0
                        ? () {
                            setState(() {
                              _start = 30;
                              startTimer();
                            });
                          }
                        : null,
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
                        otpController.isVerified.value = isVerified;
                      } catch (e) {
                        setState(() {
                          errorMessage = 'Invalid OTP code. Please try again.';
                        });
                      }
                      // send is tel to controller
                      otpController.tel.value = widget.phoneNumber.substring(4);
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
