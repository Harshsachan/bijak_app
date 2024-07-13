import 'package:bijak_app/module/commons/controller/base_controller.dart';
import 'package:bijak_app/module/afterOrder/after_order.dart';
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
    Get.to(()=>AfterOrder());

  }
}
