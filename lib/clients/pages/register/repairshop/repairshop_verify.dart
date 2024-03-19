import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_fixing/clients/controllers/repairshop/repairshopRegister_controller.dart';
import 'package:service_fixing/clients/controllers/repairshop/verifieotp_controller.dart';
import 'package:service_fixing/clients/pages/login/login.dart';
import 'package:service_fixing/clients/pages/register/repairshop/repairshop_otp.dart';
import '../../../../constants.dart';

class RepairshopVerify extends StatefulWidget {
  String shopName;
  String shopownerName;
  String age;
  String gender;
  String birthdate;
  String province;
  String district;
  String village;
  File? profileImage;
  String tel;
  bool isVerified;

  RepairshopVerify({
    required this.shopName,
    required this.shopownerName,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.province,
    required this.district,
    required this.village,
    required this.profileImage,
    required this.tel,
    required this.isVerified,
  });

  @override
  State<RepairshopVerify> createState() => _RepairshopVerifyState();
}

class _RepairshopVerifyState extends State<RepairshopVerify> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();
  final String _countryCode = '+856';
  final OtpRepairshopController otpController = Get.find();
  final RepairshopRegisterController customerRegisterController =
      RepairshopRegisterController();

  bool _hidePassword = true;
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
        child: SingleChildScrollView(
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
              Row(
                children: [
                  Container(
                    height: 55.0,
                    width: 275.0,
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
                              horizontal: 15.0, vertical: 18.0),
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
                    width: 6.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    width: 100.0,
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
                              codeSent:
                                  (String verificationId, int? resendToken) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RepairshopOtp(
                                      phoneNumber:
                                          '$_countryCode${_phoneNumberController.text}',
                                      verificationId: verificationId,
                                    ),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout:
                                  (String verificationId) {
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
              const SizedBox(
                height: 20.0,
              ),

              TextField(
                obscureText: _hidePassword,
                controller: passwordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'ລະຫັດຜ່ານ',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: _hidePassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      color: primaryColor,
                    ),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
              ),
              const SizedBox(height: 20.0),
              TextField(
                obscureText: _hidePassword,
                controller: repasswordController,
                keyboardType: TextInputType.name,
                decoration: InputDecoration(
                  labelText: 'ຢືນຢັນລະຫັດຜ່ານ',
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(width: 2.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(5),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _hidePassword = !_hidePassword;
                        });
                      },
                      icon: _hidePassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                      color: primaryColor,
                    ),
                  ),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(8),
                ],
              ),
              const SizedBox(height: 15.0),
              // Desb
              const SizedBox(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ລະຫັດຜ່ານຄວນຕັ້ງດັ່ງນີ້:',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                      Text(
                        '1.ລະຫັດຜ່ານຕ້ອງຕັ້ງດ້ວຍຕົວອັກສອນພາສາອັງກິດ ແລະ ຫູາຍກວ່າ 6ໂຕ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                      Text(
                        '2.ຕ້ອງມີຕົວອັກສອນໃຫຍ່-ນ້ອຍ ແລະ ຕົວເລກ',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                      Text(
                        '3.ຕ້ອງມີຕົວອັກສອນພິເສດນຳ(!@*&#\$%)',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'phetsarath_ot',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              SizedBox(
                height: 50.0,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    //print(widget.profileImage);
                    if (passwordController.text != repasswordController.text) {
                      // Passwords do not match, show error message
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('ລະຫັດຜ່ານບໍ່ຄືກັນ '),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      return; // Do not proceed further
                    } else {
                      if (widget.profileImage == null) {
                        // Handle the case where the image file does not exist
                        print('Image file does not exist.');
                        print(widget.profileImage);
                        return;
                      }

                      // Proceed with sending image data and other form data to the API
                      final customer = Repairshop(
                        shopName: widget.shopName,
                        shopownerName: widget.shopownerName,
                        tel: _phoneNumberController.text,
                        password: passwordController.text,
                        age: widget.age,
                        gender: widget.gender,
                        birthdate: widget.birthdate,
                        village: widget.village,
                        district: widget.district,
                        province: widget.province,
                        profileImage: widget.profileImage!,
                      );

                      try {
                        await customerRegisterController
                            .repairshopRegistrationData(customer);
                        if (customerRegisterController.isSuccess.value) {
                          // Registration successful
                          // Navigate to success page or perform other actions
                          print('success added');
                          Get.to(const LoginPage());
                        } else {
                          // Registration failed
                          // Display error message to the user or perform other actions
                          print('added error');
                        }
                      } catch (error) {
                        // Handle error
                      }
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
                    'ສົ່ງຟອມສະໝັກ',
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
    );
  }
}
