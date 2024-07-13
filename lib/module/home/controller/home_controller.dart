import 'dart:async';

import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends BaseController {
  final PageController pageController = PageController();
  Timer? timer;
  var isLoading = true.obs;
  var categories = <Category>[].obs;
  var recentlyOrdered = <Product>[].obs;
  var seasonalProducts = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
    // Simulate a delay to fetch data
    Future.delayed(Duration(seconds: 5), () {
      isLoading.value = false;
      categories.value = dummyData;
      recentlyOrdered.value = dummyData.expand((category) => category.products).take(5).toList();
      seasonalProducts.value = dummyData
          .firstWhere((category) => category.name == 'Fruits')
          .products
          .take(5)
          .toList();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    pageController.dispose();
    super.onClose();
  }

  void startAutoScroll() {
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (pageController.hasClients) {
        int nextPage = (pageController.page?.round() ?? 0) + 1;
        if (nextPage >= 3) {
          nextPage = 0;
        }
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }
}
