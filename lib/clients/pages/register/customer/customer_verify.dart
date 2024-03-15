import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/register/customer/customer_otp.dart';
import 'package:service_fixing/clients/pages/register/customer/customer_pass.dart';

import '../../../../constants.dart';
import '../../../controllers/customer/verifieotp_controller.dart';

class CustomerVerify extends StatefulWidget {
  String firstName;
  String lastName;
  String age;
  String gender;
  String birthdate;
  String province;
  String district;
  String village;
  File? profileImage;
  String tel;
  bool isVerified;

  CustomerVerify({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.province,
    required this.district,
    required this.village,
    required this.profileImage,
    required this.tel,
    //
    required this.isVerified,
  });

  @override
  State<CustomerVerify> createState() => _CustomerVerifyState();
}

class _CustomerVerifyState extends State<CustomerVerify> {
  // this is method call controller using getx
  final TextEditingController _phoneNumberController = TextEditingController();
  String _countryCode = '+856'; // Default country code
  final OtpController otpController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຢືນຢັນເບີໂທເພື່ອລົງທະບຽນ',
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
        child: Column(
          children: [
            const Text(
              'ກະລຸນາປ້ອນເບີໂທເພື່ອຢືນຢັນການລົງທະບຽນ',
              style: TextStyle(
                fontFamily: 'phetsarath_ot',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'ເບີໂທລະສັບ',
                  style: TextStyle(
                    fontFamily: 'phetsarath_ot',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 2.0,
            ),
            Container(
              height: 50.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black45,
                  width: 1.0,
                ),
              ),
              child: Obx(
                () => TextField(
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    prefixText: _countryCode,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 15.0),
                    border: InputBorder.none,
                    suffixIcon: Icon(
                      otpController.isVerified.value
                          ? Icons.check_circle
                          : Icons.error_outline,
                      color: otpController.isVerified.value
                          ? Colors.green
                          : Colors.red,
                    ),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneNumberController.text.length == 10) {
                    try {
                      await FirebaseAuth.instance.verifyPhoneNumber(
                        phoneNumber:
                            '$_countryCode${_phoneNumberController.text}',
                        verificationCompleted:
                            (PhoneAuthCredential credential) {
                          print("Verification completed");
                        },
                        verificationFailed: (FirebaseAuthException e) {
                          print("Verification failed: ${e.message}");
                        },
                        codeSent: (String verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CustomerOtp(
                                phoneNumber:
                                    '$_countryCode${_phoneNumberController.text}',
                                verificationId: verificationId,
                              ),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                          print("Code auto retrieval timeout");
                        },
                      );
                    } catch (e) {
                      print("Error: $e");
                    }
                  } else {
                    print("Invalid phone number length");
                  }
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
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 50.0,
                  width: 100.0,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                    ),
                    child: const Text(
                      'ຍົກເລີກ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10.0,
                ),
                SizedBox(
                  height: 50.0,
                  width: 100.0,
                  child: ElevatedButton(
                    onPressed: () {
                      print('Tel: ${otpController.tel}');
                      print('Is Verified: ${otpController.isVerified.value}');
                      if (otpController.isVerified.value == true) {
                        // logic go to next page
                        final profileImage = widget.profileImage;
                        Get.to(
                          CustomerPass(
                            firstName: widget.firstName,
                            lastName: widget.lastName,
                            tel: _phoneNumberController.text,
                            age: widget.age,
                            gender: widget.gender,
                            birthdate: widget.birthdate,
                            province: widget.province,
                            district: widget.district,
                            village: widget.village,
                            profileImage: profileImage,
                          ),
                        );
                      } else {
                        // messege error
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please verify your phone number.'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                      // final profileImage = widget.profileImage;
                      // Get.to(
                      //   CustomerPass(
                      //     firstName: widget.firstName,
                      //     lastName: widget.lastName,
                      //     tel: _phoneNumberController.text,
                      //     age: widget.age,
                      //     gender: widget.gender,
                      //     birthdate: widget.birthdate,
                      //     province: widget.province,
                      //     district: widget.district,
                      //     village: widget.village,
                      //     profileImage: profileImage,
                      //   ),
                      // );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 3.0,
                    ),
                    child: const Text(
                      'ຕໍ່ໄປ',
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
          ],
        ),
      ),
    );
  }
}
