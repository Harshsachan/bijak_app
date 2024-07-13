import 'package:bijak_app/module/home/controller/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartController extends BaseController {
  double calculateTotalPrice() {
    double total = cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
    return double.parse(total.toStringAsFixed(2));
  }

  void clearCart() {
    cartItems.clear();
    saveCartData();
  }

  void placeOrder() {
    clearCart();
    Get.dialog(
      AlertDialog(
        title: const Text('Order Placed'),
        content: const Text('Your order has been placed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
