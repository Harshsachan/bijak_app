import 'package:auto_size_text/auto_size_text.dart';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/controller/product_controller.dart';
import 'package:bijak_app/module/home/screen/cart_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final ProductController productController = Get.put(ProductController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Product Detail', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () {
            Get.back(result: productController.cartItems);
          },
        ),
      ),
      body: Obx(() {
        if (productController.isLoading.value) {
          return buildShimmer();
        } else {
          return buildProductDetail(context, product, productController);
        }
      }),
      floatingActionButton: Obx(
            () => Visibility(
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
        ),
      ),
    );
  }

  Widget buildProductDetail(BuildContext context, Product product, ProductController productController) {
    return SingleChildScrollView(
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8.0),
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 12.0, color: Colors.black,),
                  maxLines: 1,
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
                Text(
                  product.description,
                  style: const TextStyle(fontSize: 10.0,),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 4.0),
                Obx(() {
                  int quantity = productController.getProductQuantity(product);
                  if(quantity >0){
                   return Align(
                     alignment: Alignment.bottomRight,
                     child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              productController.removeFromCart(product);
                            },
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              productController.addToCart(product);
                            },
                          ),
                        ],
                      ),
                   );
                  }else{
                  return Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                  child: ElevatedButton(
                  onPressed: () { productController.addToCart(product);},
                  child: const AutoSizeText('Add to cart',maxLines: 1,),
                  ),
                  ),
                  );
                  }
                  // return Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     if (quantity > 0) ...[
                  //       IconButton(
                  //         icon: const Icon(Icons.remove),
                  //         onPressed: () => productController.removeFromCart(product),
                  //       ),
                  //       Text('$quantity'),
                  //       IconButton(
                  //         icon: const Icon(Icons.add),
                  //         onPressed: () => productController.addToCart(product),
                  //       ),
                  //     ] else ...[
                  //       ElevatedButton(
                  //         onPressed: () {
                  //           productController.addToCart(product);
                  //         },
                  //         child: const Text('Add to cart'),
                  //       ),
                  //     ],
                  //   ],
                  // );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          buildShimmerContainer(height: 50.0),
          const SizedBox(height: 16.0),
          buildShimmerContainer(height: 150.0),
          const SizedBox(height: 16.0),
          buildShimmerContainer(height: 50.0),
          const SizedBox(height: 8.0),
          buildShimmerContainer(height: 100.0, isHorizontalList: true),
          const SizedBox(height: 16.0),
          buildShimmerContainer(height: 50.0),
          const SizedBox(height: 8.0),
          buildShimmerContainer(height: 150.0),
        ],
      ),
    );
  }

  Widget buildShimmerContainer({required double height, bool isHorizontalList = false}) {
    return Container(
      height: height,
      color: Colors.white,
      margin: isHorizontalList
          ? const EdgeInsets.symmetric(vertical: 8.0)
          : const EdgeInsets.symmetric(horizontal: 16.0),
    );
  }
}
