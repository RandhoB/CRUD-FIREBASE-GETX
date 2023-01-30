import 'package:get/get.dart';
import 'package:qr_code_and_document/app/modules/add_product/controllers/add_product_controller.dart';
import 'package:qr_code_and_document/app/modules/catalog/controllers/catalog_controller.dart';
import 'package:qr_code_and_document/app/modules/qr_code/controllers/qr_code_controller.dart';

import '../../products/controllers/products_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
      fenix: true,
    );

    Get.lazyPut<ProductsController>(
      () => ProductsController(),
      fenix: true,
    );
    Get.lazyPut<AddProductController>(
      () => AddProductController(),
      fenix: true,
    );
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
      fenix: true,
    );
    Get.lazyPut<CatalogController>(
      () => CatalogController(),
      fenix: true,
    );
  }
}
