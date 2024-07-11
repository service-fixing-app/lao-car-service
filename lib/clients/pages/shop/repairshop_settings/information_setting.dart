import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_fixing/clients/controllers/login/auth_controller.dart';
import 'package:service_fixing/clients/controllers/shop/getRepairshopController.dart';
import 'package:service_fixing/clients/controllers/shop/updateRepairshopData.dart';
import 'package:service_fixing/constants.dart';

class InformationSetting extends StatefulWidget {
  const InformationSetting({super.key});

  @override
  State<InformationSetting> createState() => _InformationSettingState();
}

class _InformationSettingState extends State<InformationSetting> {
  final GetRepairshopController _getRepairshopController =
      Get.put(GetRepairshopController());
  final UpdateRepairshopController _updateRepairshopController =
      Get.put(UpdateRepairshopController());
  final AuthController authController = Get.find();
  bool _isEditing = false;

  late TextEditingController _shopNameController;
  late TextEditingController _owerNameController;
  late TextEditingController _telController;
  late TextEditingController _passwordController;
  late TextEditingController _ageController;
  late TextEditingController _genderController;
  late TextEditingController _villageController;
  late TextEditingController _districtController;
  late TextEditingController _provinceController;
  late TextEditingController _typeServiceController;

  @override
  void initState() {
    super.initState();
    _shopNameController = TextEditingController();
    _owerNameController = TextEditingController();
    _telController = TextEditingController();
    _passwordController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController();
    _villageController = TextEditingController();
    _districtController = TextEditingController();
    _provinceController = TextEditingController();
    _typeServiceController = TextEditingController();
  }

  @override
  void dispose() {
    _shopNameController.dispose();
    _owerNameController.dispose();
    _telController.dispose();
    _passwordController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _villageController.dispose();
    _districtController.dispose();
    _provinceController.dispose();
    _typeServiceController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        final updateRepairshopData = UpdateRepairshopData(
          shopName: _shopNameController.text,
          owerName: _owerNameController.text,
          tel: _telController.text,
          password: _passwordController.text,
          age: _ageController.text,
          gender: _genderController.text,
          village: _villageController.text,
          district: _districtController.text,
          province: _provinceController.text,
          typeService: _typeServiceController.text,
          profileImage: _imageFile,
          existingProfileImageUrl:
              _getRepairshopController.getOneRepairshop['profile_image'],
        );
        _updateRepairshopController.updateRepairshopData(updateRepairshopData);
      }
    });
  }

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
          'ຂໍ້ມູນພື້ນຖານ',
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
      body: FutureBuilder(
        future: _getRepairshopController.fetchOneRepairshop(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            // final userData = authController.userData['user'];
            final repairshopData = _getRepairshopController.getOneRepairshop;
            _shopNameController.text = repairshopData['shop_name'];
            _owerNameController.text = repairshopData['manager_name'];
            _telController.text = repairshopData['tel'].toString();
            _passwordController.text = repairshopData['password'];
            _ageController.text = repairshopData['age'].toString();
            _genderController.text = repairshopData['gender'];
            _villageController.text = repairshopData['village'];
            _districtController.text = repairshopData['district'];
            _provinceController.text = repairshopData['province'];
            _typeServiceController.text = repairshopData['type_service'];

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
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
                                    : NetworkImage(
                                            '${repairshopData['profile_image']}')
                                        as ImageProvider,
                              ),
                            ],
                          ),
                          if (_isEditing)
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
                                                leading: const Icon(
                                                    Icons.photo_library),
                                                title: const Text('ຮູບພາບ'),
                                                onTap: () {
                                                  Navigator.of(context).pop();
                                                  _getImage(
                                                      ImageSource.gallery);
                                                },
                                              ),
                                              ListTile(
                                                leading: const Icon(
                                                    Icons.camera_alt),
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
                                  tooltip: 'ແກ້ໄຂຮູບພາບ Profile',
                                  child: const Icon(Icons.edit),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _shopNameController,
                      label: 'ຊື່ຮ້ານ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _owerNameController,
                      label: 'ຊື່ເຈົ້າຂອງຮ້ານ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _telController,
                      label: 'ເບີໂທລະສັບ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'ລະຫັດຜ່ານ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _ageController,
                      label: 'ອາຍຸ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _genderController,
                      label: 'ເພດ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _villageController,
                      label: 'ບ້ານ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _districtController,
                      label: 'ເມືອງ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _provinceController,
                      label: 'ແຂວງ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    _buildTextField(
                      controller: _typeServiceController,
                      label: 'ປະເພດບໍລິການ',
                      isEditing: _isEditing,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 52,
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                        ),
                        onPressed: _toggleEdit,
                        child: Text(
                          _isEditing ? 'ບັນທືກ' : 'ແກ້ໄຂ',
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildTextField(
      {TextEditingController? controller,
      String? label,
      required bool isEditing}) {
    return TextField(
      controller: controller,
      readOnly: !isEditing,
      decoration: InputDecoration(
        labelText: label,
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
    );
  }
}
