import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../home/controllers/home_controller.dart';
import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);

  final ProductModel product = Get.arguments;

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    codeC.text = product.code;
    nameC.text = product.name;
    qtyC.text = product.qty.toString();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Detail Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 200,
                width: 200,
                child: QrImage(
                  data: product.code,
                  version: QrVersions.auto,
                ),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextFormField(
              readOnly: true,
              keyboardType: TextInputType.number,
              controller: codeC,
              maxLength: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                labelText: 'Code Product',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                // enabledBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: Colors.blueGrey,
                //   ),
                // ),
              ),
              onChanged: (value) {},
            ),
            TextFormField(
              controller: nameC,
              maxLength: 20,
              decoration: const InputDecoration(
                labelText: 'Name Product',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              onChanged: (value) {},
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: qtyC,
              maxLength: 3,
              decoration: const InputDecoration(
                labelText: 'Quantity Product',
                labelStyle: TextStyle(
                  color: Colors.blueGrey,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Obx(() => controller.isLoadingUpdate.isTrue
                    ? Text("Loading...")
                    : Text("Update Product")),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
              onPressed: () async {
                if (controller.isLoadingUpdate.isFalse) {
                  if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                    //....proses update data
                    controller.isLoadingUpdate(true);
                    Map<String, dynamic> hasil =
                        await controller.updateProduct({
                      "id": product.productId,
                      "name": nameC.text,
                      "qty": int.tryParse(qtyC.text) ?? 0,
                    });
                    controller.isLoadingUpdate(false);
                    Get.back();
                    homeC.selectedIndex(0);
                    Get.snackbar(
                      // snackPosition: SnackPosition.BOTTOM,
                      padding: EdgeInsets.all(50),
                      hasil["error"] == true ? "Error" : "Berhasil",
                      hasil["message"],
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.snackbar(
                      "Error",
                      "Semua data wajib di isi",
                      duration: const Duration(
                        seconds: 2,
                      ),
                    );
                  }
                }
              },
            ),
            const SizedBox(
              height: 20.0,
            ),
            TextButton(
              onPressed: () {
                Get.defaultDialog(
                  title: "Delete Product",
                  middleText: "Are you sure to delete this product ?",
                  actions: [
                    ElevatedButton.icon(
                      icon: const Icon(Icons.cancel),
                      label: const Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey,
                      ),
                      onPressed: () => Get.back(),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.delete),
                      label: Obx(
                        () => controller.isLoadingDelete.isFalse
                            ? Text("Delete")
                            : Text("Loading..."),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      onPressed: () async {
                        if (controller.isLoadingDelete.isFalse) {
                          if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                            controller.isLoadingDelete(true);
                            Map<String, dynamic> hasil =
                                await controller.deleteProduct(
                              product.productId,
                            );
                            controller.isLoadingDelete(false);
                            Get.back(); //balik ke halaman detail
                            Get.back(); //balik ke halaman product
                            Get.snackbar(
                              hasil["error"] == true ? "Error" : "Berhasil",
                              hasil["message"],
                              duration: const Duration(seconds: 2),
                            );
                          }
                        } else {
                          Get.snackbar("Error", "Semua data wajib diisi");
                        }
                      },
                    ),
                  ],
                );
              },
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.redAccent,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Delete Product",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            )
          ]),
        ));
  }
}
