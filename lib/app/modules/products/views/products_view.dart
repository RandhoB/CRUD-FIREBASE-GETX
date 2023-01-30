import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/data/models/product_model.dart';
import 'package:qr_code_and_document/app/modules/detail_product/views/detail_product_view.dart';

import 'package:qr_code_and_document/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../controller/auth_controller.dart';
import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  final productsC = Get.put(ProductsController());
  ProductsView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, dynamic> hasil = await authC.doLogout();
              if (hasil["error"] == false) {
                Get.offAllNamed(Routes.LOGIN);
              } else {
                Get.snackbar("Error", hasil["error"]);
              }
            },
            icon: const Icon(
              Icons.logout,
              size: 24.0,
            ),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: productsC.streamProducts(),
          builder: (context, snapProduct) {
            if (snapProduct.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapProduct.data!.docs.isEmpty) {
              return Center(
                child: Text("Produk Tidak Ada"),
              );
            }

            List<ProductModel> allProducts = [];

            for (var element in snapProduct.data!.docs) {
              allProducts.add(ProductModel.fromJson(element.data()));
            }
            return ListView.builder(
              itemCount: allProducts.length,
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                ProductModel product = allProducts[index];
                return Card(
                    elevation: 5,
                    child: InkWell(
                      onTap: (() {
                        Get.toNamed(Routes.DETAIL_PRODUCT, arguments: product);
                      }),
                      child: Container(
                        height: 100,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.code,
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    product.name,
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(
                                    height: 3.0,
                                  ),
                                  Text(
                                    "Jumlah : ${product.qty}",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              child: QrImage(
                                size: 200,
                                version: QrVersions.auto,
                                data: product.code,
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
              },
            );
          }),
    );
  }
}
