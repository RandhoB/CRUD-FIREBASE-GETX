import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';

class AuthController extends GetxController {
  String? uid;

  late FirebaseAuth auth;

  Future<Map<String, dynamic>> doLogin(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);

      return {
        "error": false,
        "message": "Berhasil Login.",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      //error general
      return {
        "error": true,
        "message": "Tidak dapat login.",
      };
    }
  }

  Future<Map<String, dynamic>> doLogout() async {
    try {
      await auth.signOut();

      return {
        "error": false,
        "message": "Berhasil Logout.",
      };
    } on FirebaseAuthException catch (e) {
      return {
        "error": true,
        "message": "${e.message}",
      };
    } catch (e) {
      //error general
      return {
        "error": true,
        "message": "Tidak dapat logout.",
      };
    }
  }

  @override
  void onInit() {
    auth = FirebaseAuth.instance;

    auth.authStateChanges().listen((event) {
      uid = event?.uid;
    });
    super.onInit();
  }
}
