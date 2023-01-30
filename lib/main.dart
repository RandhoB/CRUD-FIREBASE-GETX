import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/controller/auth_controller.dart';
import 'package:qr_code_and_document/app/modules/loading/views/loading_view.dart';
import 'package:qr_code_and_document/firebase_options.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController(), permanent: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: firebaseAuth.authStateChanges(),
      builder: (context, snapAuth) {
        if (snapAuth.connectionState == ConnectionState.waiting)
          return LoadingView();
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "QR Scan",
          initialRoute: snapAuth.hasData ? Routes.HOME : Routes.LOGIN,
          getPages: AppPages.routes,
          theme: ThemeData.light().copyWith(
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.blueGrey,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
              selectedItemColor: Colors.orange,
              unselectedItemColor: Colors.grey,
              showUnselectedLabels: true,
            ),
          ),
        );
      },
    );
  }
}
