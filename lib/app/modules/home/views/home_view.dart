import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:qr_code_and_document/app/modules/add_product/views/add_product_view.dart';
import 'package:qr_code_and_document/app/modules/catalog/views/catalog_view.dart';
import 'package:qr_code_and_document/app/modules/products/views/products_view.dart';
import 'package:qr_code_and_document/app/modules/qr_code/views/qr_code_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final homeC = Get.put(HomeController());

  HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(
      (() => DefaultTabController(
            length: 4,
            initialIndex: homeC.selectedIndex.value,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: IndexedStack(
                index: homeC.selectedIndex.value,
                children: [
                  ProductsView(),
                  AddProductView(),
                  QrCodeView(),
                  CatalogView()
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                currentIndex: homeC.selectedIndex.value,
                onTap: (value) {
                  homeC.selectedIndex.value = value;
                  // controller.update();
                },
                items: [
                  BottomNavigationBarItem(
                    label: "Product",
                    icon: Icon(
                      Icons.production_quantity_limits,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Add Product",
                    icon: Icon(
                      Icons.add,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "QR Code",
                    icon: Icon(
                      Icons.qr_code,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Catalog",
                    icon: Icon(
                      Icons.keyboard_alt_outlined,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
