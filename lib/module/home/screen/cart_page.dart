import 'dart:convert';

import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartItems;

  CartPage({required this.cartItems});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    cartItems = List.from(widget.cartItems);
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
      setState(() {
        cartItems = decodedList.map((item) => Product.fromJson(item)).toList();
      });
    }
  }

  double _calculateTotalPrice() {
    return cartItems.fold(0, (total, current) => total + (current.price * current.quantity));
  }

  void _clearCart() {
    setState(() {
      cartItems.clear();
    });
    _saveCartData();
  }

  void _placeOrder() {
    // Clear the cart and save
    _clearCart();

    // Show a confirmation dialog or message
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Order Placed'),
        content: Text('Your order has been placed successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Get.back();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void addToCart(Product product) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == product.id) {
        setState(() {
          cartItems[i].quantity++;
        });
        _saveCartData();
        break;
      }
    }
  }

  void removeFromCart(Product product) {
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].id == product.id) {
        setState(() {
          if (cartItems[i].quantity > 1) {
            cartItems[i].quantity--;
          } else {
            cartItems.removeAt(i);
          }
        });
        _saveCartData();
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = _calculateTotalPrice();

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(result: cartItems);
          },
        ),
      ),
      body: cartItems.isEmpty
          ? buildEmptyCart()
          : Column(
        children: [
          Expanded(child: buildCartList()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Total: \$${totalPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _placeOrder,
                  child: Text('Place Order'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart, size: 64.0, color: Colors.grey),
          SizedBox(height: 16.0),
          Text(
            'Your Cart is Empty',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget buildCartList() {
    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        Product product = cartItems[index];
        return ListTile(
          leading: Image.asset(product.image, width: 60.0, height: 60.0, fit: BoxFit.cover),
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.remove),
                onPressed: () {
                  removeFromCart(product);
                },
              ),
              Text('${product.quantity}'),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  addToCart(product);
                },
              ),
            ],
          ),
          onTap: () {
            Get.to(() => ProductDetailPage(product: product));
          },
        );
      },
    );
  }
}
