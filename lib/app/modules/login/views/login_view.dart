import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/controller/auth_controller.dart';
import 'package:qr_code_and_document/app/modules/home/views/home_view.dart';
import 'package:qr_code_and_document/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC =
      TextEditingController(text: "admin@gmail.com");
  final TextEditingController passC = TextEditingController(text: "admin123");

  final AuthController authC = Get.find<AuthController>();
  // final heightPadding = Get.height * 0.2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Selamat Datang'),
          centerTitle: true,
        ),
        body: ListView(
          padding: const EdgeInsets.all(40),
          children: [
            Container(
              height: 180.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://firebase.google.com/images/social.png",
                  ),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    16.0,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50.0,
            ),
            TextFormField(
              controller: emailC,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                suffixIcon: Icon(
                  Icons.email,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                helperText: 'Enter your email address',
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 20.0,
            ),
            Obx(
              () => TextFormField(
                controller: passC,
                maxLength: 20,
                obscureText: controller.isHidden.value,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.blueGrey,
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.isHidden.toggle();
                    },
                    icon: Icon(
                      controller.isHidden.isFalse
                          ? Icons.remove_red_eye
                          : Icons.remove_red_eye_outlined,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blueGrey,
                    ),
                  ),
                  helperText: 'Enter your password',
                ),
                onChanged: (value) {},
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.login),
              label: Obx((() => controller.isLoading.isFalse
                  ? Text("Login")
                  : Text("Loading..."))),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              onPressed: () async {
                if (controller.isLoading.isFalse) {
                  if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                    controller.isLoading(true);
                    Map<String, dynamic> hasil =
                        await authC.doLogin(emailC.text, passC.text);
                    controller.isLoading(false);

                    if (hasil["error"] == true) {
                      Get.snackbar("Error", hasil["message"]);
                    } else {
                      Get.offAllNamed(Routes.HOME);
                    }
                  } else {
                    Get.snackbar("Error", "Email dan password wajib di isi");
                  }
                }
              },
            ),
          ],
        ));
  }
}
