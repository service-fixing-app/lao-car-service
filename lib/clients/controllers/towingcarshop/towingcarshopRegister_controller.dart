import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';

class Towingcarshop {
  final String shopName;
  final String shopownerName;
  final String tel;
  final String password;
  final String age;
  final String gender;
  final String birthdate;
  final String village;
  final String district;
  final String province;
  final String typeService;
  final File? profileImage;
  final File? documentImage;

  Towingcarshop({
    required this.shopName,
    required this.shopownerName,
    required this.tel,
    required this.password,
    required this.age,
    required this.gender,
    required this.birthdate,
    required this.village,
    required this.district,
    required this.province,
    required this.typeService,
    required this.profileImage,
    required this.documentImage,
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

  Future<String?> uploadDocumentImageToFirebaseStorage() async {
    try {
      if (documentImage == null) return null;

      // Get image name
      String imageName = documentImage!.path.split('/').last;

      // Upload image to Firebase Storage
      Reference ref =
          FirebaseStorage.instance.ref().child('Documents/$imageName');
      await ref.putFile(File(documentImage!.path));

      // Get download URL of the uploaded image
      String imageUrl = await ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      print('Error uploading document image to Firebase Storage: $e');
      return null;
    }
  }
}

class TowingcarshopRegisterController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> towingcarshopRegistrationData(
      Towingcarshop towingcarshop) async {
    try {
      isLoading.value = true;

      // Upload profile image to Firebase Storage and get image URL
      String? profileImageUrl =
          await towingcarshop.uploadProfileImageToFirebaseStorage();

      // Upload document image to Firebase Storage and get image URL
      String? documentImageUrl =
          await towingcarshop.uploadDocumentImageToFirebaseStorage();

      // Send shop data along with image URLs to database
      if (profileImageUrl != null && documentImageUrl != null) {
        var response = await http.post(
          Uri.parse('http://10.0.2.2:5000/api/towingtruck/addTowingtruck'),
          body: {
            'towingTruck_name': towingcarshop.shopName,
            'shopOwner_name': towingcarshop.shopownerName,
            'tel': towingcarshop.tel,
            'password': towingcarshop.password,
            'age': towingcarshop.age,
            'gender': towingcarshop.gender,
            'birthdate': towingcarshop.birthdate,
            'village': towingcarshop.village,
            'district': towingcarshop.district,
            'province': towingcarshop.province,
            'type_service': towingcarshop.typeService,
            'profile_image':
                profileImageUrl, // Send the profile image URL to the database
            'document_verify':
                documentImageUrl, // Send the document image URL to the database
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
            // Handle validation errors
            print('Validation error: ${response.body}');
            // Display validation errors to the user or perform other actions
          } else {
            // Handle other errors (e.g., server errors)
            print('Server error');
            // Display a generic error message to the user or perform other actions
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
