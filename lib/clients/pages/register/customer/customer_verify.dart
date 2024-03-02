import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service_fixing/clients/pages/register/customer/customer_otp.dart';

import '../../../../constants.dart';

class CustomerVerify extends StatefulWidget {
  const CustomerVerify({Key? key}) : super(key: key);

  @override
  State<CustomerVerify> createState() => _CustomerVerifyState();
}

class _CustomerVerifyState extends State<CustomerVerify> {
  final TextEditingController _phoneNumberController = TextEditingController();
  String _countryCode = '+856'; // Default country code
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຢືຢັນເບີໂທເພື່ອລົງທະບຽນ',
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.black45,
                  width: 1.0,
                ),
              ),
              child: TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  prefixText: _countryCode,
                  hintText: '',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
                  border: InputBorder.none,
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(10)],
              ),
            ),
            const SizedBox(
              height: 50.0,
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
          ],
        ),
      ),
    );
  }
}
