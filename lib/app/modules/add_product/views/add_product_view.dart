import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/routes/app_pages.dart';

import '../../home/controllers/home_controller.dart';
import '../controllers/add_product_controller.dart';

class AddProductView extends GetView<AddProductController> {
  AddProductView({Key? key}) : super(key: key);

  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  final homeC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                controller: codeC,
                maxLength: 5,
                decoration: const InputDecoration(
                  labelText: 'Code Product',
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
                  child: Obx(() => controller.isLoading.isTrue
                      ? Text("Loading...")
                      : Text("Add Product")),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                ),
                onPressed: () async {
                  if (controller.isLoading.isFalse) {
                    if (codeC.text.isNotEmpty &&
                        nameC.text.isNotEmpty &&
                        qtyC.text.isNotEmpty) {
                      controller.isLoading(true);
                      Map<String, dynamic> hasil = await controller.addProduct({
                        "code": codeC.text,
                        "name": nameC.text,
                        "qty": int.tryParse(qtyC.text) ?? 0,
                      });
                      controller.isLoading(false);
                      // Get.toNamed(Routes.PRODUCTS);
                      homeC.selectedIndex(0);
                      Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                          hasil["message"]);
                    } else {
                      Get.snackbar("Error", "Semua data wajib diisi");
                    }
                  }
                },
              ),
            ],
          ),
        ));
  }
}
