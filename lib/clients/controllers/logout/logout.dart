import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:service_fixing/clients/pages/login/login.dart';

class LogoutController extends GetxController {
  var isLoading = false.obs;

  // api for virtual emulator
  // String url = "http://10.0.2.2:5000/api/login/loginUser";
  // real android device
  String urlLogout = "http://192.168.43.127:5000/api/customer/logout";

  Future<void> logout() async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(urlLogout),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
      );
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        //print('logout success');
        Get.offAll(() => const LoginPage());
      } else {
        print('logut error : ${response.statusCode}');
      }
    } catch (error) {
      isLoading(false);
    }
  }
}
