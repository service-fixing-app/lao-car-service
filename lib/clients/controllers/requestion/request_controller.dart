import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/pages/customer/home/home_page.dart';

// model
class Request {
  final String senderName;
  final String senderTel;
  final String receiverName;
  final String receiverTel;
  final String message;

  Request({
    required this.senderName,
    required this.senderTel,
    required this.receiverName,
    required this.receiverTel,
    required this.message,
  });
}

class RequestController extends GetxController {
  var isLoading = false.obs;
  var isSuccess = false.obs;

  Future<void> requestmessageData(Request message) async {
    try {
      isLoading.value = true;
      var response = await http.post(
        Uri.parse('http://192.168.43.127:5000/api/request/addRequestMessage'),
        body: {
          'sender_name': message.senderName,
          'sender_tel': message.senderTel,
          'receiver_name': message.receiverName,
          'receiver_tel': message.receiverTel,
          'message': message.message,
          'status': 'warning',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful
        isSuccess.value = true;
        // Navigate to success page or perform other actions
        Get.to(const HomePage());
      } else {
        // Registration failed
        isSuccess.value = false;
        // print("Error: ${response.statusCode}");
        if (response.statusCode == 400) {
          // Handle validation errors
          //print('Validation error: ${response.body}');
          // Display validation errors to the user or perform other actions
        } else {
          // Handle other errors (e.g., server errors)
          //print('Server error');
          // Display a generic error message to the user or perform other actions
        }
      }
    } catch (error) {
      // Handle network errors or exceptions
      isSuccess.value = false;
      //print("Error: $error");
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
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:service_fixing/clients/pages/customer/home/home_page.dart';

// // model
// class Request {
//   final String senderName;
//   final String senderTel;
//   final String receiverName;
//   final String receiverTel;
//   final String message;

//   Request({
//     required this.senderName,
//     required this.senderTel,
//     required this.receiverName,
//     required this.receiverTel,
//     required this.message,
//   });
// }

// class RequestController extends GetxController {
//   var isLoading = false.obs;
//   var isSuccess = false.obs;

//   Future<void> requestmessageData(Request message) async {
//     try {
//       isLoading.value = true;
//       var response = await http.post(
//         Uri.parse('http://192.168.43.127:5000/api/request/addRequestMessage'),
//         body: {
//           'sender_name': message.senderName,
//           'sender_tel': message.senderTel,
//           'receiver_name': message.receiverName,
//           'receiver_tel': message.receiverTel,
//           'message': message.message,
//           'status': 'warning',
//         },
//       );

//       if (response.statusCode == 200 || response.statusCode == 201) {
//         // Registration successful
//         isSuccess.value = true;
//         // Call the notification API
//         await callNotificationAPI();
//         // Navigate to success page or perform other actions
//         Get.to(const HomePage());
//       } else {
//         // Registration failed
//         isSuccess.value = false;
//         // Handle error response
//       }
//     } catch (error) {
//       // Handle network errors or exceptions
//       isSuccess.value = false;
//       // Handle error
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   Future<void> callNotificationAPI() async {
//     try {
//       var devices = ["d6c79b80-02b8-4f81-8f51-50c3e49e94b1"];
//       var response = await http.post(
//         Uri.parse(
//             'http://192.168.43.127:5000/api/notification/pushNotificationToDevice'),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         // Add any required request body parameters
//         body: {
//           'devices': devices,
//         },
//       );
//       if (response.statusCode == 200) {
//         // Notification API call successful
//         // Handle success
//       } else {
//         // Notification API call failed
//         // Handle error
//       }
//     } catch (error) {
//       // Handle network errors or exceptions
//       // Handle error
//     }
//   }

//   @override
//   void onClose() {
//     isLoading.close();
//     isSuccess.close();
//     super.onClose();
//   }
// }
