import 'package:bijak_app/module/home/controller/base_controller.dart';
import 'package:get/get.dart';

class ProductController extends BaseController {
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() async {
    await Future.delayed(Duration(seconds: 1));
    isLoading.value = false;
  }
}
