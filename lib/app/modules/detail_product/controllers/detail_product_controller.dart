import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class DetailProductController extends GetxController {
  //TODO: Implement DetailProductController
  RxBool isLoadingUpdate = false.obs;
  RxBool isLoadingDelete = false.obs;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> updateProduct(Map<String, dynamic> data) async {
    try {
      await firestore.collection("products").doc(data["id"]).update(
        {
          "name": data["name"],
          "qty": data["qty"],
        },
      );
      return {
        "error": false,
        "message": "Data berhasil di update",
      };
    } catch (e) {
      return {"error": true, "message": "Update gagal..."};
    }
  }

  Future<Map<String, dynamic>> deleteProduct(String id) async {
    try {
      await firestore.collection("products").doc(id).delete();
      return {
        "error": false,
        "message": "Data berhasil di hapus",
      };
    } catch (e) {
      return {"error": true, "message": "Gagal Delete..."};
    }
  }
}
