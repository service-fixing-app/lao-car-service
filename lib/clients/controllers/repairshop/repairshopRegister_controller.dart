import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../models/repairshop_registerModel.dart';

class RepairshopController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  void saveRepairshopData(Repairshop repairshop) async {
    try {
      isLoading.value = true;

      // Your API endpoint for saving repairshop data
      var apiUrl = 'https://example.com/save-repairshop-data';

      // Prepare the request body
      var requestBody = {
        'first_name': repairshop.firstName,
        'last_name': repairshop.lastName,
        'tel': repairshop.tel,
        'password': repairshop.password,
        'age': repairshop.age.toString(),
        'gender': repairshop.gender,
        'birthdate': repairshop.birthdate,
        'village': repairshop.village,
        'district': repairshop.district,
        'province': repairshop.province,
      };

      print('from controller ${requestBody}');

      // Send the request
      // var response = await http.post(
      //   Uri.parse(apiUrl),
      //   body: requestBody,
      // );

      // // Handle response
      // if (response.statusCode == 200) {
      //   // Registration successful
      //   isSuccess.value = true;
      // } else {
      //   // Registration failed
      //   isSuccess.value = false;
      //   print("Error: ${response.statusCode}");
      //   // Handle errors accordingly
      // }
    } catch (error) {
      // Handle network errors or exceptions
      isSuccess.value = false;
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }
}
