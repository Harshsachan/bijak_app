import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/controller/product_controller.dart';
import 'package:bijak_app/module/home/screen/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back(result: productController.cartItems);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.asset(product.image, fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8.0),
                    Text(
                      product.name,
                      style: const TextStyle(fontSize: 12.0, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.weight,
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      '\$${product.price}',
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Obx(() {
                      int quantity = productController.getProductQuantity(product);
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (quantity > 0) ...[
                            IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () => productController.removeFromCart(product),
                            ),
                            Text('$quantity'),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: () => productController.addToCart(product),
                            ),
                          ] else ...[
                            ElevatedButton(
                              onPressed: () {
                                productController.addToCart(product);
                              },
                              child: const Text('Add to cart'),
                            ),
                          ],
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Obx(()=>Visibility(
        visible: productController.cartItems.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () async {
            var result = await Get.to(() => CartPage(cartItems: productController.cartItems));
            if (result != null) {
              productController.cartItems.value = result;
              productController.saveCartData();
            }
          }, child: const Icon(Icons.shopping_cart),),
      ),),
    );
  }
}
