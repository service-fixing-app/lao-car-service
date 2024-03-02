import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../constants.dart';

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
      {"val": 2, "name": "ແຂວງຜົ້ງສາລີ"},
      {"val": 3, "name": "ແຂວງຫຼວງນ້ຳທາ"},
      {"val": 4, "name": "ແຂວງບໍ່ແກ້ວ"},
      {"val": 5, "name": "ແຂວງອຸດົມໄຊ"},
      {"val": 6, "name": "ແຂວງຫລວງພະບາງ"},
      {"val": 7, "name": "ແຂວງໄຊຍະບູລີ"},
      {"val": 8, "name": "ແຂວງຫົວພັນ"},
      {"val": 9, "name": "ແຂວງຊຽງຂວາງ"},
      {"val": 10, "name": "ແຂວງວຽງຈັນ"},
      {"val": 11, "name": "ແຂວງໄຊສົມບູນ"},
      {"val": 12, "name": "ແຂວງບໍລິຄຳໄຊ"},
      {"val": 13, "name": "ແຂວງຄຳມ່ວນ "},
      {"val": 14, "name": "ແຂວງສະຫວັນນະເຂດ"},
      {"val": 15, "name": "ແຂວງສາລະວັນ"},
      {"val": 16, "name": "ແຂວງຈຳປາສັກ"},
      {"val": 17, "name": "ແຂວງເຊກອງ"},
      {"val": 18, "name": "ແຂວງອັດຕະປື"},
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
      {"ID": 10, "Name": "ເມືອງບຸນໃຕ້", "ParentId": 2},
      {"ID": 11, "Name": "ເມືອງຂວາ", "ParentId": 2},
      {"ID": 12, "Name": "ເມືອງໃໝ່", "ParentId": 2},
      {"ID": 13, "Name": "ເມືອງຍອດອູ", "ParentId": 2},
      {"ID": 14, "Name": "ເມືອງຜົ້ງສາລີ", "ParentId": 2},
      {"ID": 15, "Name": "ເມືອງສຳພັນ", "ParentId": 2},
      {"ID": 16, "Name": "ເມືອງບຸນເໜືອ", "ParentId": 2},
      {"ID": 17, "Name": "ເມືອງຫຼວງນໍ້າທາ", "ParentId": 3},
      {"ID": 18, "Name": "ເມືອງສີງ", "ParentId": 3},
      {"ID": 19, "Name": "ເມືອງລອງ", "ParentId": 3},
      {"ID": 20, "Name": "ເມືອງວຽງພູຄາ", "ParentId": 3},
      {"ID": 21, "Name": "ເມືອງນາແລ", "ParentId": 3},
      {"ID": 22, "Name": "ເມືອງຫ້ວຍຊາຍ", "ParentId": 4},
      {"ID": 23, "Name": "ເມືອງຕົ້ນເຜິ້ງ", "ParentId": 4},
      {"ID": 24, "Name": "ເມືອງເມິງ", "ParentId": 4},
      {"ID": 25, "Name": "ເມືອງຜາອຸດົມ", "ParentId": 4},
      {"ID": 26, "Name": "ເມືອງປາກທາ", "ParentId": 4},
      {"ID": 27, "Name": "ເມືອງໄຊ", "ParentId": 5},
      {"ID": 28, "Name": "ເມືອງຫລາ", "ParentId": 5},
      {"ID": 29, "Name": "ເມືອງນາໝໍ້", "ParentId": 5},
      {"ID": 30, "Name": "ເມືອງງາ", "ParentId": 5},
      {"ID": 31, "Name": "ເມືອງແບ່ງ", "ParentId": 5},
      {"ID": 32, "Name": "ເມືອງຮຸນ", "ParentId": 5},
      {"ID": 33, "Name": "ເມືອງປາກແບ່ງ", "ParentId": 5},
      {"ID": 34, "Name": "ເມືອງຫຼວງພະບາງ", "ParentId": 6},
      {"ID": 35, "Name": "ເມືອງຊຽງເງິນ", "ParentId": 6},
      {"ID": 36, "Name": "ເມືອງນານ", "ParentId": 6},
      {"ID": 37, "Name": "ເມືອງປາກອູ", "ParentId": 6},
      {"ID": 38, "Name": "ເມືອງນ້ຳບາກ", "ParentId": 6},
      {"ID": 39, "Name": "ເມືອງງອຍ", "ParentId": 6},
      {"ID": 40, "Name": "ເມືອງປາກແຊງ", "ParentId": 6},
      {"ID": 41, "Name": "ເມືອງໂພນໄຊງ", "ParentId": 6},
      {"ID": 42, "Name": "ເມືອງຈອມເພັດ", "ParentId": 6},
      {"ID": 43, "Name": "ເມືອງວຽງຄຳ", "ParentId": 6},
      {"ID": 44, "Name": "ເມືອງພູຄູນ", "ParentId": 6},
      {"ID": 44, "Name": "ເມືອງໂພນທອງ", "ParentId": 6},
      {"ID": 45, "Name": "ເມືອງບໍ່ແຕນ", "ParentId": 7},
      {"ID": 46, "Name": "ເມືອງຫົງສາ", "ParentId": 7},
      {"ID": 47, "Name": "ເມືອງແກ່ນທ້າວ", "ParentId": 7},
      {"ID": 48, "Name": "ເມືອງຄອບ", "ParentId": 7},
      {"ID": 49, "Name": "ເມືອງເງິນ", "ParentId": 7},
      {"ID": 50, "Name": "ເມືອງປາກລາຍ", "ParentId": 7},
      {"ID": 51, "Name": "ເມືອງພຽງ", "ParentId": 7},
      {"ID": 52, "Name": "ເມືອງທົ່ງມີໄຊ", "ParentId": 7},
      {"ID": 53, "Name": "ເມືອງໄຊຍະບູລີ", "ParentId": 7},
      {"ID": 54, "Name": "ເມືອງຊຽງຮ່ອນ", "ParentId": 7},
      {"ID": 55, "Name": "ເມືອງໄຊສະຖານ", "ParentId": 7},
      {"ID": 56, "Name": "ເມືອງຊຳເໜືອ", "ParentId": 8},
      {"ID": 57, "Name": "ເມືອງຊຽງຄໍ້", "ParentId": 8},
      {"ID": 58, "Name": "ເມືອງຮ້ຽມ", "ParentId": 8},
      {"ID": 59, "Name": "ເມືອງວຽງໄຊ", "ParentId": 8},
      {"ID": 60, "Name": "ເມືອງຫົວເມືອງ", "ParentId": 8},
      {"ID": 61, "Name": "ເມືອງຊຳໃຕ້", "ParentId": 8},
      {"ID": 62, "Name": "ເມືອງສົບເບົາ", "ParentId": 8},
      {"ID": 63, "Name": "ເມືອງແອດ", "ParentId": 8},
      {"ID": 64, "Name": "ເມືອງກວັນ", "ParentId": 8},
      {"ID": 65, "Name": "ເມືອງຊ່ອນ", "ParentId": 8},
      {"ID": 66, "Name": "ເມືອງແປກ(ໂພນສະຫວັນ)", "ParentId": 9},
      {"ID": 67, "Name": "ເມືອງຄຳ", "ParentId": 9},
      {"ID": 68, "Name": "ເມືອງໜອງແຮດ", "ParentId": 9},
      {"ID": 69, "Name": "ເມືອງຄູນ", "ParentId": 9},
      {"ID": 70, "Name": "ເມືອງໝອກ", "ParentId": 9},
      {"ID": 71, "Name": "ເມືອງພູກູດ", "ParentId": 9},
      {"ID": 72, "Name": "ເມືອງຜາໄຊ", "ParentId": 9},
      {"ID": 73, "Name": "ເມືອງເຟືອງ", "ParentId": 10},
      {"ID": 74, "Name": "ເມືອງຫີນເຫີບ", "ParentId": 10},
      {"ID": 75, "Name": "ເມືອງກາສີ", "ParentId": 10},
      {"ID": 76, "Name": "ເມືອງແກ້ວອຸດົມ", "ParentId": 10},
      {"ID": 77, "Name": "ເມືອງແມດ", "ParentId": 10},
      {"ID": 78, "Name": "ເມືອງໂພນໂຮງ", "ParentId": 10},
      {"ID": 79, "Name": "ເມືອງທຸລະຄົມ", "ParentId": 10},
      {"ID": 80, "Name": "ເມືອງວັງວຽງ", "ParentId": 10},
      {"ID": 81, "Name": "ເມືອງວັງວຽງ", "ParentId": 10},
      {"ID": 82, "Name": "ເມືອງຊະນະຄາມ", "ParentId": 10},
      {"ID": 83, "Name": "ເມືອງໝື່ນ", "ParentId": 10},
      {"ID": 84, "Name": "ເມືອງລ້ອງແຈ້ງ", "ParentId": 11},
      {"ID": 85, "Name": "ເມືອງທ່າໂທມ", "ParentId": 11},
      {"ID": 86, "Name": "ເມືອງອະນຸວົງ", "ParentId": 11},
      {"ID": 87, "Name": "ເມືອງລ້ອງຊານ", "ParentId": 11},
      {"ID": 88, "Name": "ເມືອງຮົ່ມ", "ParentId": 11},
      {"ID": 89, "Name": "ເມືອງປາກຊັນ", "ParentId": 12},
      {"ID": 90, "Name": "ເມືອງທ່າພະບາດ", "ParentId": 12},
      {"ID": 91, "Name": "ເມືອງປາກກະດິງ", "ParentId": 12},
      {"ID": 92, "Name": "ເມືອງຄຳເກີດ(ຫຼັກ20)", "ParentId": 12},
      {"ID": 93, "Name": "ເມືອງບໍລິຄັນ", "ParentId": 12},
      {"ID": 94, "Name": "ເມືອງວຽງທອງ", "ParentId": 12},
      {"ID": 95, "Name": "ເມືອງໄຊຈຳພອນ", "ParentId": 12},
      {"ID": 96, "Name": "ເມືອງທ່າແຂກ", "ParentId": 13},
      {"ID": 97, "Name": "ເມືອງມະຫາໄຊ", "ParentId": 13},
      {"ID": 98, "Name": "ເມືອງໜອງບົກ", "ParentId": 13},
      {"ID": 99, "Name": "ເມືອງຫີນບູນ", "ParentId": 13},
      {"ID": 100, "Name": "ເມືອງຍົມມະລາດ", "ParentId": 13},
      {"ID": 101, "Name": "ເມືອງບົວລະພາ", "ParentId": 13},
      {"ID": 102, "Name": "ເມືອງນາກາຍ", "ParentId": 13},
      {"ID": 103, "Name": "ເມືອງເຊບັ້ງໄຟ", "ParentId": 13},
      {"ID": 104, "Name": "ເມືອງໄຊບົວທອງ", "ParentId": 13},
      {"ID": 105, "Name": "ເມືອງຄູນຄຳ", "ParentId": 13},
      {"ID": 106, "Name": "ເມືອງໄກສອນພົມວິຫານ", "ParentId": 14},
      {"ID": 107, "Name": "ເມືອງອຸທຸມພອນ", "ParentId": 14},
      {"ID": 108, "Name": "ເມືອງອາດສະພັງທອງ", "ParentId": 14},
      {"ID": 109, "Name": "ເມືອງພີນ", "ParentId": 14},
      {"ID": 110, "Name": "ເມືອງເຊໂປນ", "ParentId": 14},
      {"ID": 111, "Name": "ເມືອງນອງ", "ParentId": 14},
      {"ID": 112, "Name": "ເມືອງທ່າປາງທອງ", "ParentId": 14},
      {"ID": 113, "Name": "ເມືອງສອງຄອນ", "ParentId": 14},
      {"ID": 114, "Name": "ເມືອງຈຳພອນ", "ParentId": 14},
      {"ID": 115, "Name": "ເມືອງຊົນນະບູລີ", "ParentId": 14},
      {"ID": 116, "Name": "ເມືອງໄຊບູລີ", "ParentId": 14},
      {"ID": 117, "Name": "ເມືອງວິລະບູລີ", "ParentId": 14},
      {"ID": 118, "Name": "ເມືອງອາດສະພອນ", "ParentId": 14},
      {"ID": 119, "Name": "ເມືອງໄຊພູທອງ", "ParentId": 14},
      {"ID": 120, "Name": "ເມືອງພະລານໄຊ", "ParentId": 14},
      {"ID": 121, "Name": "ເມືອງສາລະວັນ", "ParentId": 15},
      {"ID": 122, "Name": "ເມືອງລະຄອນເພັງ", "ParentId": 15},
      {"ID": 123, "Name": "ເມືອງວາປີ", "ParentId": 15},
      {"ID": 124, "Name": "ເມືອງເລົ່າງາມ", "ParentId": 15},
      {"ID": 125, "Name": "ເມືອງຕຸ້ມລານ", "ParentId": 15},
      {"ID": 126, "Name": "ເມືອງຕະໂອ້ຍ", "ParentId": 15},
      {"ID": 127, "Name": "ເມືອງຄົງເຊໂດນ", "ParentId": 15},
      {"ID": 128, "Name": "ເມືອງສະມ້ວຍ", "ParentId": 15},
      {"ID": 129, "Name": "ເມືອງປາກເຊ", "ParentId": 16},
      {"ID": 130, "Name": "ເມືອງຊະນະສົມບູນ", "ParentId": 16},
      {"ID": 131, "Name": "ເມືອງບາຈຽງຈະເລີນສຸກ", "ParentId": 16},
      {"ID": 132, "Name": "ເມືອງປາກຊ່ອງ", "ParentId": 16},
      {"ID": 133, "Name": "ເມືອປະທຸມພອນ", "ParentId": 16},
      {"ID": 134, "Name": "ເມືອງໂພນທອງ", "ParentId": 16},
      {"ID": 135, "Name": "ເມືອງຈຳປາສັກ", "ParentId": 16},
      {"ID": 136, "Name": "ເມືອງສຸຂຸມາ", "ParentId": 16},
      {"ID": 137, "Name": "ເມືອງມູນລະປະໂມກ", "ParentId": 16},
      {"ID": 138, "Name": "ເມືອງໂຂງ", "ParentId": 16},
      {"ID": 139, "Name": "ເມືອງທ່າແຕງ", "ParentId": 17},
      {"ID": 140, "Name": "ເມືອງລະມາມ", "ParentId": 17},
      {"ID": 141, "Name": "ເມືອງກະລຶມ", "ParentId": 17},
      {"ID": 142, "Name": "ເມືອງດັກຈຶງ", "ParentId": 17},
      {"ID": 143, "Name": "ເມືອງໄຊເຊດຖາ", "ParentId": 18},
      {"ID": 144, "Name": "ເມືອງສາມັກຄີໄຊ", "ParentId": 18},
      {"ID": 145, "Name": "ເມືອງສະໜາມໄຊ", "ParentId": 18},
      {"ID": 146, "Name": "ເມືອງຊານໄຊ", "ParentId": 18},
      {"ID": 147, "Name": "ເມືອງພູວົງ", "ParentId": 18},
    ];
  }

  //uploa user profile
  File? _imageFile;

  final ImagePicker _picker = ImagePicker();

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      } else {
        print('No image selected.');
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
                                          title:
                                              const Text('Pick from Gallery'),
                                          onTap: () {
                                            Navigator.of(context).pop();
                                            _getImage(ImageSource.gallery);
                                          },
                                        ),
                                        ListTile(
                                          leading: const Icon(Icons.camera_alt),
                                          title: const Text('Take a Photo'),
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
                          'canel',
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
                          Get.toNamed('/customerVerify');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 3.0,
                        ),
                        child: const Text(
                          'submit',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
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
