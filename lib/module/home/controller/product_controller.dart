import 'dart:convert';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductController extends GetxController {
  var cartItems = <Product>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cartItems');
    if (cartJson != null) {
      List<dynamic> decodedCart = jsonDecode(cartJson);
      cartItems.value = decodedCart.map((item) => Product.fromJson(item)).toList();
    }
  }

  Future<void> _saveCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cartItems', cartJson);
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
    cartItems.refresh(); // Ensure UI updates
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
    cartItems.refresh(); // Ensure UI updates
  }

  int getProductQuantity(Product product) {
    for (var item in cartItems) {
      if (item.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }
}
