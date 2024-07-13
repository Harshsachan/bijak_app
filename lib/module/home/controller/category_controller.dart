// category_controller.dart

import 'package:Bijak/data/dummy_data.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categories = <Category>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  void loadCategories() {
    categories.addAll(dummyData);
  }
}
