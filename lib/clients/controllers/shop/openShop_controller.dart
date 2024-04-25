import 'package:get/get.dart';

class OpenshopController extends GetxController {
  var isOpen = false.obs;
}

// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';

// class OpenshopController extends GetxController {
//   var isSwitcheded = false;

//   final GetStorage switchDataController = GetStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     initialize();
//   }

//   void initialize() {
//     if (switchDataController.hasData('getXIsSwitched')) {
//       isSwitcheded = switchDataController.read('getXIsSwitched') ?? false;
//       update();
//     }
//   }

//   void changeSwitchState(bool value) {
//     isSwitcheded = value;
//     switchDataController.write('getXIsSwitched', value);
//     update();
//   }
// }
