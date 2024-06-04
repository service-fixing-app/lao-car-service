import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class GetReviewsShopImage extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;
  var imageUrls = <String>[].obs;

  Future<void> reviewsShopImage(String shopId) async {
    try {
      isLoading.value = true;

      var response = await http.get(
        Uri.parse(
            'http://192.168.43.127:5000/api/reviewsShopImage/getReviewShopImageByShopId/$shopId'),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        isSuccess.value = true;

        final List<dynamic> data = jsonDecode(response.body);
        imageUrls
            .assignAll(data.map((item) => item['images'].toString()).toList());
        // Print the data
        // print('Status update success');
        // print('Image URLs: $imageUrls');
      } else {
        isSuccess.value = false;
        // print("Error: ${response.statusCode}");
        // print("Response body: ${response.body}");
      }
    } catch (error) {
      isSuccess.value = false;
      // print("Error: $error");
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
