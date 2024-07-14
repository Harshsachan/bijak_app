import 'package:Bijak/module/commons/widget/add_to_cart_btn.dart';
import 'package:Bijak/module/commons/widget/inc_dec_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:Bijak/data/dummy_data.dart';
import 'package:Bijak/module/commons/widget/app_bar.dart';
import 'package:Bijak/module/product/controller/product_controller.dart';
import 'package:Bijak/module/cart/screen/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return WillPopScope(
      onWillPop: () async {
        Get.back(result: productController.cartItems);
        return false; // Returning false prevents the default back navigation
      },
      child: Scaffold(
        appBar: CustomAppBar(
          title: 'Product Detail',
          leadingIcon: Icons.arrow_back,
          leadingOnPressed: () {
            Get.back(result: productController.cartItems);
          },
        ),
        body: Obx(() {
          if (productController.isLoading.value) {
            return _buildShimmer();
          } else {
            return _buildProductDetail(context, product, productController);
          }
        }),
        floatingActionButton: Obx(() => Visibility(
          visible: productController.cartItems.isNotEmpty,
          child: FloatingActionButton(
            onPressed: () async {
              var result = await Get.to(() => CartPage(cartItems: productController.cartItems));
              if (result != null) {
                productController.cartItems.value = result;
                productController.saveCartData();
              }
            },
            child: const Icon(Icons.shopping_cart),
          ),
        )),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          _buildShimmerContainer(height: 50.0),
          const SizedBox(height: 16.0),
          _buildShimmerContainer(height: 150.0),
          const SizedBox(height: 16.0),
          _buildShimmerContainer(height: 50.0),
          const SizedBox(height: 8.0),
          _buildShimmerContainer(height: 100.0, isHorizontalList: true),
          const SizedBox(height: 16.0),
          _buildShimmerContainer(height: 50.0),
          const SizedBox(height: 8.0),
          _buildShimmerContainer(height: 150.0),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({required double height, bool isHorizontalList = false}) {
    return Container(
      height: height,
      color: Colors.white,
      margin: isHorizontalList
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }

  Widget _buildProductDetail(BuildContext context, Product product, ProductController productController) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      child: Stack(
        children: [
          SizedBox(
            height: height / 2,
            width: double.infinity,
            child: AspectRatio(
              aspectRatio: 2 / 3,
              child: Image.asset(product.image, fit: BoxFit.cover),
            ),
          ),
          Positioned.fill(
            top: (height / 2) - 20,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
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
                    Divider(thickness: 1 ,color: Colors.grey.shade100,),
                    const SizedBox(height: 4.0),
                    Text(
                      'Approx - ${product.weight}',
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      'Price - \$${product.price}',
                      style: const TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2.0),
                    Text(
                      "Description",
                      style: const TextStyle(fontSize: 10.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      product.description,
                      style: const TextStyle(fontSize: 10.0),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Obx(() {
                      int quantity = productController.getProductQuantity(product);
                      if (quantity > 0) {
                        return _buildQuantityControl(productController, product, quantity);
                      } else {
                        return _buildAddToCartButton(productController, product);
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControl(ProductController productController, Product product, int quantity) {
    return Align(
      alignment: Alignment.bottomRight,
      child :IncrementDecrementRow(
        cartQuantity: quantity,
        onIncrement: () => productController.addToCart(product),
        onDecrement: () => productController.removeFromCart(product),
      )
    );
  }

  Widget _buildAddToCartButton(ProductController productController, Product product) {
    return Align(
      alignment: Alignment.bottomRight,
      child :AddToCartButton(
        onPressed: () => productController.addToCart(product),
      ),

    );
  }
}
