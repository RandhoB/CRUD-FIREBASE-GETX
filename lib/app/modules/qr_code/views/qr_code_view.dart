import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/routes/app_pages.dart';

import '../controllers/qr_code_controller.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Halaman QR Code'),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Silahkan klik tombol dibawah ini untuk\nmenscan QR Code di Katalog",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.document_scanner),
              label: const Text("Scan QR Code"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () async {
                String barcode = await FlutterBarcodeScanner.scanBarcode(
                  "#000000",
                  "Cancel",
                  true,
                  ScanMode.QR,
                );

                //Get data dari firebase search by product id
                Map<String, dynamic> hasil =
                    await controller.getProductById(barcode);
                if (hasil["error"] == false) {
                  Get.toNamed(Routes.DETAIL_PRODUCT, arguments: hasil["data"]);
                } else {
                  Get.snackbar(
                    "Error",
                    hasil["message"],
                    duration: Duration(seconds: 2),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
