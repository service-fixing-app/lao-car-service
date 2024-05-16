import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_fixing/clients/pages/register/towingcarshop/towingcarshop_verify.dart';
import '../../../../constants.dart';

class TowingcarshopForm extends StatefulWidget {
  const TowingcarshopForm({super.key});

  @override
  State<TowingcarshopForm> createState() => _TowingcarshopFormState();
}

class _TowingcarshopFormState extends State<TowingcarshopForm> {
  // controller put data to model using getx
  TextEditingController shopNameController = TextEditingController();
  TextEditingController shopOwnerNameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController typeServiceController = TextEditingController();

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
  List<Map<String, dynamic>> typeService = [];

  String? selectedProvince;
  String? selectedState;

  String? selectTypeService;

  @override
  void initState() {
    super.initState();

    typeService = [
      {"val": 1, "name": "ບໍລິການແກ່ລົດນ້ອຍ"},
      {"val": 2, "name": "ບໍລິການແກ່ລົດໃຫຍ່"},
    ];

    provinces = [
      {"val": 1, "name": "ນະຄອນຫຼວງຈັນ"},
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
        print('No profile image selected.');
      }
    });
  }

  // upload ducoment image
  File? _documentImageFile;

  Future<void> _getDocumentImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _documentImageFile = File(pickedFile.path);
      } else {
        print('No document image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ຟອມລົງທະບຽນຮ້ານບໍລິການຮັບແກ່ລົດ',
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
                            tooltip: 'ເພີ່ມຮູບພາບ',
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
                  controller: shopNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ຊື່ຮ້ານແກ່ລົດ',
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
                  controller: shopOwnerNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: 'ຊື່ ແລະນາມສະກຸນເຈົ້າຂອງຮ້ານ',
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
                    items: provinces.map((provinces) {
                      return DropdownMenuItem<String>(
                        value: provinces['name'],
                        child: Text(provinces['name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedProvince = newValue;
                        selectedState = null;
                        states = stateMasters
                            .where((state) =>
                                state['ParentId'] ==
                                provinces.firstWhere(
                                  (country) => country['name'] == newValue,
                                )['val'])
                            .toList();
                      });
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
                // const SizedBox(height: 20.0),
                // // type off serivce
                // TextField(
                //   controller: typeServiceController,
                //   keyboardType: TextInputType.name,
                //   decoration: InputDecoration(
                //     labelText: 'ປະເພດບໍລິການແກ່ລົດ',
                //     labelStyle: const TextStyle(
                //       fontSize: 18,
                //       fontFamily: 'phetsarath_ot',
                //       fontWeight: FontWeight.w500,
                //     ),
                //     border: OutlineInputBorder(
                //       borderRadius: BorderRadius.circular(10.0),
                //       borderSide: const BorderSide(width: 2.0),
                //     ),
                //     contentPadding: const EdgeInsets.symmetric(
                //       horizontal: 20.0,
                //       vertical: 18.0,
                //     ),
                //   ),
                //   inputFormatters: [
                //     LengthLimitingTextInputFormatter(50),
                //   ],
                // ),
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
                    value: selectTypeService,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      hintText: 'ເລືອກບໍລິການແກ່ລົດ',
                      hintStyle: TextStyle(
                        fontSize: 18,
                        fontFamily: 'phetsarath_ot',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    items: typeService.map((type) {
                      return DropdownMenuItem<String>(
                        value: type['name'],
                        child: Text(type['name']),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectTypeService = newValue;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20.0),
                // document verify
                const Text(
                  'ຮູບພາບບັດປະຈຳຕົວເປັນເອກະສານຢັ້ງຢືນ',
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'phetsarath_ot',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SafeArea(
                          child: Wrap(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.photo_library),
                                title: const Text('ຮູບພາບ'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _getDocumentImage(ImageSource.gallery);
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.camera_alt),
                                title: const Text('ຖ່າຍຮູບ'),
                                onTap: () {
                                  Navigator.of(context).pop();
                                  _getDocumentImage(ImageSource.camera);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    height: 200.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: _documentImageFile != null
                        ? Image.file(
                            _documentImageFile!,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                                Text(
                                  'ອັບໂລບຮູບພາບ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'phetsarath_ot',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 20.0),
                // button data
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50.0,
                        // width: 140.0,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
                        // width: 180.0,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_imageFile == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // title: const Text('warning'),
                                    content:
                                        const Text('ກະລຸນາອັບໂລດຮູບ profile'),
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
                            } else if (_documentImageFile == null) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    // title: const Text('warning'),
                                    content: const Text(
                                        'ກະລຸນາອັບໂລດຮູບເອກະສານການເປີດຮ້ານ'),
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
                            } else {
                              Get.to(
                                TowingshopVerify(
                                  shopName: shopNameController.text,
                                  shopownerName: shopOwnerNameController.text,
                                  age: ageController.text,
                                  gender: _selectGender,
                                  birthdate: _selectedDate != null
                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : '',
                                  province: selectedProvince ?? '',
                                  district: selectedState ?? '',
                                  village: villageController.text,
                                  // typeService: typeServiceController.text,
                                  typeService: selectTypeService ?? '',
                                  profileImage: _imageFile!,
                                  documentImage: _documentImageFile!,
                                  tel: '',
                                  isVerified: false,
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
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
