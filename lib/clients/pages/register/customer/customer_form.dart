import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';
import 'customer_verify.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  String _selectGender = '';
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  // selected province and district
  List<Map<String, dynamic>> provinces = [];
  List<Map<String, dynamic>> stateMasters = [];
  List<Map<String, dynamic>> states = [];

  String? selectedProvince;
  String? selectedState;

  @override
  void initState() {
    super.initState();

    provinces = [
      {"val": 1, "name": "ນະຄອນຫຼວງຈັນ"},
      // {"val": 2, "name": "ແຂວງຜົ້ງສາລີ"},
      // {"val": 3, "name": "ແຂວງຫຼວງນ້ຳທາ"},
      // {"val": 4, "name": "ແຂວງບໍ່ແກ້ວ"},
      // {"val": 5, "name": "ແຂວງອຸດົມໄຊ"},
      // {"val": 6, "name": "ແຂວງຫລວງພະບາງ"},
      // {"val": 7, "name": "ແຂວງໄຊຍະບູລີ"},
      // {"val": 8, "name": "ແຂວງຫົວພັນ"},
      // {"val": 9, "name": "ແຂວງຊຽງຂວາງ"},
      // {"val": 10, "name": "ແຂວງວຽງຈັນ"},
      // {"val": 11, "name": "ແຂວງໄຊສົມບູນ"},
      // {"val": 12, "name": "ແຂວງບໍລິຄຳໄຊ"},
      // {"val": 13, "name": "ແຂວງຄຳມ່ວນ "},
      // {"val": 14, "name": "ແຂວງສະຫວັນນະເຂດ"},
      // {"val": 15, "name": "ແຂວງສາລະວັນ"},
      // {"val": 16, "name": "ແຂວງຈຳປາສັກ"},
      // {"val": 17, "name": "ແຂວງເຊກອງ"},
      // {"val": 18, "name": "ແຂວງອັດຕະປື"},
    ];

    stateMasters = [
      {"ID": 1, "Name": "ເມືອງຈັນທະບູລີ", "ParentId": 1},
      {"ID": 2, "Name": "ເມືອງໄຊເສດຖາ", "ParentId": 1},
      {"ID": 3, "Name": "ເມືອງສີໂຄດຕະບອງ", "ParentId": 1},
      {"ID": 4, "Name": "ເມືອງສີສັດຕະນາກ", "ParentId": 1},
      {"ID": 5, "Name": "ເມືອງຫາດຊາຍຟອງ", "ParentId": 1},
      {"ID": 6, "Name": "ເມືອງນາຊາຍທອງ", "ParentId": 1},
      {"ID": 7, "Name": "ເມືອງໄຊທານີ", "ParentId": 1},
      {"ID": 8, "Name": "ເມືອງສັງທອງ", "ParentId": 1},
      {"ID": 9, "Name": "ເມືອງໃໝ່ປາກງື່ມ", "ParentId": 1},
      // {"ID": 10, "Name": "ເມືອງບຸນໃຕ້", "ParentId": 2},
    ];
  }

  // this is method call controller using getx
  //CustomerRegisterController customerRegisterController = Get.find();

  // degine varrible in textfield
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController villageController = TextEditingController();

  //uploa user profile
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();
  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        // print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຟອມລົງທະບຽນລູກຄ້າ',
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // upload proflie image
                Center(
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: _imageFile != null
                                ? FileImage(_imageFile!)
                                : null,
                            child: _imageFile == null
                                ? const Icon(Icons.person, size: 60)
                                : null,
                          ),
                        ],
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          width: 45,
                          height: 45,
                          child: FloatingActionButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Wrap(
                                      children: [
                                        ListTile(
                                          leading:
                                              const Icon(Icons.photo_library),
                                          title: const Text('ຮູບພາບ'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _getImage(ImageSource.gallery);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('ຖ່າຍຮູບ'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _getImage(ImageSource.camera);
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            },
                            tooltip: 'Pick Image',
                            child: const Icon(Icons.add_a_photo),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // personal imfomation
                const Text(
                  'ຂໍ້ມູນພື້ນຖານ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                // Text Feild register
                const SizedBox(
                  height: 20.0,
                ),
                TextField(
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ຊື່ຜູ້ໃຊ້',
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
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),

                const SizedBox(
                  height: 25.0,
                ),

                TextField(
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ນາມສະກຸນ',
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
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),

                TextField(
                  controller: ageController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ອາຍຸ',
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
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text(
                  'ເພດ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //gender
                Row(
                  children: <Widget>[
                    Radio<String?>(
                      value: 'ຊາຍ',
                      groupValue: _selectGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectGender = value!;
                        });
                      },
                    ),
                    const Text('ຊາຍ'),
                    Radio<String?>(
                      value: 'ຍິງ',
                      groupValue: _selectGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectGender = value!;
                        });
                      },
                    ),
                    const Text('ຍິງ'),
                    Radio<String?>(
                      value: 'ອື່ນໆ',
                      groupValue: _selectGender,
                      onChanged: (String? value) {
                        setState(() {
                          _selectGender = value!;
                        });
                      },
                    ),
                    const Text('ອື່ນໆ'),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // birth date
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: _selectedDate != null
                              ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                              : '',
                        ),
                        decoration: InputDecoration(
                          labelText: 'ວັນທີ່ເດືອນປີເກີດ',
                          labelStyle: const TextStyle(
                            fontSize: 18,
                            fontFamily: 'phetsarath_ot',
                            fontWeight: FontWeight.w500,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.calendar_month_outlined),
                            onPressed: () => _selectDate(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                // select Provice and district

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedProvince,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: 'ເລືອກແຂວງ',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: provinces.map((province) {
                      return DropdownMenuItem<String>(
                        value: province['name'],
                        child: Text(province['name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(
                        () {
                          selectedProvince = newValue;
                          selectedState = null;
                          states = stateMasters
                              .where((state) =>
                                  state['ParentId'] ==
                                  provinces.firstWhere(
                                    (province) => province['name'] == newValue,
                                  )['val'])
                              .toList();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  child: DropdownButtonFormField<String>(
                    value: selectedState,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: 'ເລືອກເມືອງ',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: states.map((state) {
                      return DropdownMenuItem<String>(
                        value: state['Name'],
                        child: Text(state['Name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedState = newValue;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                TextField(
                  controller: villageController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ບ້ານ',
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
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(50),
                  ],
                ),
                const SizedBox(height: 20.0),
                // button data
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        // width: 180.0,
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
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        // width: 190.0,
                        child: ElevatedButton(
                          onPressed: () {
                            // Call the method to update registration data
                            // customerRegisterController.updateRegistrationData(
                            //   firstName: firstNameController.text,
                            //   lastName: lastNameController.text,
                            //   age: ageController.text,
                            //   gender: _selectGender,
                            //   birthdate: _selectedDate != null
                            //       ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                            //       : '',
                            //   province: selectedProvince ??
                            //       '', // Retrieve selected province
                            //   district: selectedState ??
                            //       '', // Retrieve selected district
                            //   village: villageController.text,
                            //   profileImage: _imageFile != null
                            //       ? _imageFile!.path
                            //       : '', // Retrieve profile image path
                            //   password: '', // will get value in next page
                            //   tel: '', // will get value in next page
                            // );
                            // String fileName =
                            //     path.basename(_imageFile?.path ?? '');
                            // String profileImage =
                            //     _imageFile != null ? fileName : '';
                            // Navigate to the next page
                            //print('image path : ${_imageFile}');
                            Get.to(
                              CustomerVerify(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                age: ageController.text,
                                gender: _selectGender,
                                birthdate: _selectedDate != null
                                    ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                    : '',
                                province: selectedProvince ?? '',
                                district: selectedState ?? '',
                                village: villageController.text,
                                profileImage: _imageFile!,
                                tel: '',
                                isVerified: false,
                              ),
                            );
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
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
