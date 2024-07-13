
import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/commons/widget/app_bar.dart';
import 'package:bijak_app/module/cart/controller/cart_controller.dart';
import 'package:bijak_app/module/product/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  final List<Product> cartItems;

  CartPage({super.key, required this.cartItems});

  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
      onWillPop: () async {
        Get.back(result: cartController.cartItems);
        return false; // Returning false prevents the default back navigation
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Cart',
          leadingIcon: Icons.arrow_back,
          leadingOnPressed: () {
            Get.back(result: cartController.cartItems);
          },
        ),
        body: cartController.cartItems.isEmpty
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

                    'Total: \$${cartController.calculateTotalPrice()}',
                    style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: cartController.placeOrder,
                    child: const Text('Place Order'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget buildEmptyCart() {
    return const Center(
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
      itemCount: cartController.cartItems.length,
      itemBuilder: (context, index) {
        Product product = cartController.cartItems[index];
        return ListTile(
          leading: Image.asset(product.image, width: 60.0, height: 60.0, fit: BoxFit.cover),
          title: Text(product.name),
          subtitle: Text('\$${product.price}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  cartController.removeFromCart(product);
                },
              ),
              Text('${product.quantity}'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cartController.addToCart(product);
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
