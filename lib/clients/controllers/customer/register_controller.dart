// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;

// class Customer {
//   final String firstName;
//   final String lastName;
//   final String tel;
//   final String password;
//   final String age;
//   final String gender;
//   final String birthdate;
//   final String village;
//   final String district;
//   final String province;
//   final File profileImage;

//   Customer({
//     required this.firstName,
//     required this.lastName,
//     required this.tel,
//     required this.password,
//     required this.age,
//     required this.gender,
//     required this.birthdate,
//     required this.village,
//     required this.district,
//     required this.province,
//     required this.profileImage,
//   });

//   Future<http.StreamedResponse> uploadProfileImage(String url) async {
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.fields['first_name'] = firstName;
//     request.fields['last_name'] = lastName;
//     request.fields['tel'] = tel;
//     request.fields['password'] = password;
//     request.fields['age'] = age;
//     request.fields['gender'] = gender;
//     request.fields['birthdate'] = birthdate;
//     request.fields['village'] = village;
//     request.fields['district'] = district;
//     request.fields['province'] = province;

//     // Attach the image file
//     var imageFile = await http.MultipartFile.fromPath(
//       'profile_image',
//       profileImage.path,
//     );
//     request.files.add(imageFile);

//     var response = await request.send();
//     return response;
//   }
// }

// class CustomerRegisterController extends GetxController {
//   var isLoading = false.obs;
//   var isSuccess = false.obs;

//   Future<void> customerRegistrationData(Customer customer) async {
//     try {
//       isLoading.value = true;

//       var response = await customer
//           .uploadProfileImage('http://10.0.2.2:5000/api/customer/addCustomer');

//       print(response.statusCode);

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Registration successful
//         isSuccess.value = true;
//         // Navigate to success page or perform other actions
//       } else {
//         // Registration failed
//         isSuccess.value = false;
//         print("Error: ${response.statusCode}");
//         if (response.statusCode == 400) {
//           // Handle validation errors
//           print('Validation error: ${await response.stream.bytesToString()}');
//           // Display validation errors to the user or perform other actions
//         } else {
//           // Handle other errors (e.g., server errors)
//           print('Server error');
//           // Display a generic error message to the user or perform other actions
//         }
//       }
//     } catch (error) {
//       // Handle network errors or exceptions
//       isSuccess.value = false;
//       print("Error: $error");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   @override
//   void onClose() {
//     isLoading.close();
//     isSuccess.close();
//     super.onClose();
//   }
// }
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

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
  final File? profileImage;

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

  Future<String?> uploadProfileImageToFirebaseStorage() async {
    try {
      if (profileImage == null) return null;

      // Get image name
      String imageName = profileImage!.path.split('/').last;

      // Upload image to Firebase Storage
      Reference ref = FirebaseStorage.instance.ref().child('Images/$imageName');
      await ref.putFile(File(profileImage!.path));

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      return null;
    }
  }
}

class CustomerRegisterController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> customerRegistrationData(Customer customer) async {
    try {
      isLoading.value = true;

      // Upload profile image to Firebase Storage and get image URL
      String? imageUrl = await customer.uploadProfileImageToFirebaseStorage();

      // Send shop data along with image URL to database
      if (imageUrl != null) {
        var response = await http.post(
          Uri.parse('http://192.168.43.127:5000/api/customer/addCustomer'),
          body: {
            'first_name': customer.firstName,
            'last_name': customer.lastName,
            'tel': customer.tel,
            'password': customer.password,
            'age': customer.age,
            'gender': customer.gender,
            'birthdate': customer.birthdate,
            'village': customer.village,
            'district': customer.district,
            'province': customer.province,
            'profile_image': imageUrl, // Send the image URL to the database
            'role': 'customer',
          },
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          // Registration successful
          isSuccess.value = true;
          // Navigate to success page or perform other actions
        } else {
          // Registration failed
          isSuccess.value = false;
          print("Error: ${response.statusCode}");
          if (response.statusCode == 400) {
            print('Validation error: ${response.body}');
          } else {
            print('Server error');
          }
        }
      } else {
        print('Error: Image upload failed');
        isSuccess.value = false;
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
