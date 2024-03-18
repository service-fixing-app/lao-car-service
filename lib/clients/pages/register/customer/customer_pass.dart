import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:service_fixing/clients/controllers/customer/register_controller.dart';
import '../../../../constants.dart';

class CustomerPass extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String age;
  final String gender;
  final String birthdate;
  final String province;
  final String district;
  final String village;
  final File? profileImage;
  final String tel;

  const CustomerPass({
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
  });

  @override
  State<CustomerPass> createState() => _CustomerPassState();
}

class _CustomerPassState extends State<CustomerPass> {
  final CustomerRegisterController customerRegisterController =
      CustomerRegisterController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController repasswordController = TextEditingController();

  bool _hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ສ້າງລະຫັດຜ່ານໃໝ່ຂອງທ່ານ',
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
              'ກະລຸນາປ້ອນລະຫັດຜ່ານໃໝ່ຂອງທ່ານ',
              style: TextStyle(
                fontFamily: 'phetsarath_ot',
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 20.0),
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
                  vertical: 18.0,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8),
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
                  vertical: 18.0,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.all(8),
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

            const SizedBox(height: 15.0),
            SizedBox(
              height: 50.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
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
                    final customer = Customer(
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      tel: widget.tel,
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
                          .customerRegistrationData(customer);
                      if (customerRegisterController.isSuccess.value) {
                        // Registration successful
                        // Navigate to success page or perform other actions
                        print('success added');
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
    );
  }
}
