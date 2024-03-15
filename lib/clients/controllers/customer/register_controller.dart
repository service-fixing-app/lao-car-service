import 'dart:io';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Customer {
  final String firstName;
  final String lastName;
  final String tel;
  final String password;
  final String age;
  final String gender;
  final String birthdate;
  final String village;
  final String district;
  final String province;
  final File profileImage;

  Customer({
    required this.firstName,
    required this.lastName,
    required this.tel,
    required this.password,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.village,
    required this.district,
    required this.province,
    required this.profileImage,
  });

  Future<http.StreamedResponse> uploadProfileImage(String url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields['first_name'] = firstName;
    request.fields['last_name'] = lastName;
    request.fields['tel'] = tel;
    request.fields['password'] = password;
    request.fields['age'] = age;
    request.fields['gender'] = gender;
    request.fields['birthdate'] = birthdate;
    request.fields['village'] = village;
    request.fields['district'] = district;
    request.fields['province'] = province;

    // Attach the image file
    var imageFile = await http.MultipartFile.fromPath(
      'profile_image',
      profileImage.path,
    );
    request.files.add(imageFile);

    var response = await request.send();
    return response;
  }
}

class CustomerRegisterController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> customerRegistrationData(Customer customer) async {
    try {
      isLoading.value = true;

      var response = await customer
          .uploadProfileImage('http://10.0.2.2:5000/api/customer/addCustomer');

      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        // Navigate to success page or perform other actions
      } else {
        // Registration failed
        isSuccess.value = false;
        print("Error: ${response.statusCode}");
        if (response.statusCode == 400) {
          // Handle validation errors
          print('Validation error: ${await response.stream.bytesToString()}');
          // Display validation errors to the user or perform other actions
        } else {
          // Handle other errors (e.g., server errors)
          print('Server error');
          // Display a generic error message to the user or perform other actions
        }
      }
    } catch (error) {
      // Handle network errors or exceptions
      isSuccess.value = false;
      print("Error: $error");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    isLoading.close();
    isSuccess.close();
    super.onClose();
  }
}
