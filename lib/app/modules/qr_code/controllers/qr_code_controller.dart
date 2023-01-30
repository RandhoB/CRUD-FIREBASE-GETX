import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:qr_code_and_document/app/data/models/product_model.dart';

class QrCodeController extends GetxController {
  FirebaseFirestore firebase = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getProductById(String codeBarang) async {
    try {
      var hasil = await firebase
          .collection("products")
          .where("code", isEqualTo: codeBarang)
          .get();

      if (hasil.docs.isEmpty) {
        return {
          "error": true,
          "message": "Tidak ada product di database",
        };
      }

      Map<String, dynamic> data = hasil.docs.first.data();

      return {
        "error": false,
        "message": "Berhasil mendapatkan data product dari code ini",
        "data": ProductModel.fromJson(data),
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak dapat menemukan detail product dari barcode ini."
      };
    }
  }
}
