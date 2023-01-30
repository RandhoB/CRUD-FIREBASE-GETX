import 'package:get/get.dart';

class LoginController extends GetxController {
  // ignore: todo
  //TODO: Implement LoginController
  final RxBool isHidden = true.obs;
  final RxBool isLoading = false.obs;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
