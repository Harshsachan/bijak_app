import 'dart:async';
import 'dart:convert';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  final PageController pageController = PageController();
  Timer? timer;
  var isLoading = true.obs;
  var categories = <Category>[].obs;
  var recentlyOrdered = <Product>[].obs;
  var seasonalProducts = <Product>[].obs;
  var cartItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
    loadCartData();
    // Simulate a delay to fetch data
    Future.delayed(Duration(seconds: 1), () {
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

  Future<void> loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cartItems');
    if (cartJson != null) {
      List<dynamic> decodedCart = jsonDecode(cartJson);
      cartItems.value = decodedCart.map((item) => Product.fromJson(item)).toList();
    }
  }

  Future<void> saveCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cartItems', cartJson);
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

  void removeFromCart(Product product) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == product.id) {
        if (cartItems[i].quantity > 1) {
          cartItems[i].quantity--;
        } else {
          cartItems.removeAt(i);
        }
        break;
      }
    }
    saveCartData();
    cartItems.refresh(); // Ensure UI refresh after modification
  }

  void addToCart(Product product) {
    bool found = false;
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == product.id) {
        cartItems[i].quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      cartItems.add(Product(
        id: product.id,
        name: product.name,
        weight: product.weight,
        image: product.image,
        price: product.price,
        description: product.description,
        quantity: 1,
      ));
    }
    saveCartData();
    cartItems.refresh(); // Ensure UI refresh after modification
  }
}
