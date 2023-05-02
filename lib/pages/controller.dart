import 'package:get/get.dart';

class pagecontroller extends GetxController {
  String email;
  @override
  void onInit() {
    email = Get.arguments['email'];
    super.onInit();
  }
}
