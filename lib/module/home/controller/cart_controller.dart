import 'dart:convert';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartController extends GetxController {
  var cartItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartData();
  }

  Future<void> _saveCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cartItems', cartJson);
  }

  Future<void> _loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cartItems');
    if (cartJson != null) {
      List<dynamic> decodedList = jsonDecode(cartJson);
      cartItems.value = decodedList.map((item) => Product.fromJson(item)).toList();
    }
  }

  double calculateTotalPrice() {
    double total = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    return double.parse(total.toStringAsFixed(2));
  }


  void clearCart() {
    cartItems.clear();
    _saveCartData();
  }

  void placeOrder() {
    clearCart();
    Get.dialog(
      AlertDialog(
        title: Text('Order Placed'),
        content: Text('Your order has been placed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
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
    _saveCartData();
    cartItems.refresh(); // Ensure UI refresh after modification
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
    _saveCartData();
    cartItems.refresh(); // Ensure UI refresh after modification
  }
}
