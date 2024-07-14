// home_page.dart


import 'package:Bijak/module/commons/widget/add_to_cart_btn.dart';
import 'package:Bijak/module/commons/widget/inc_dec_btn.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:Bijak/module/commons/widget/app_bar.dart';
import 'package:Bijak/module/home/controller/home_controller.dart';
import 'package:Bijak/module/cart/screen/cart_page.dart';
import 'package:Bijak/module/product/screen/product_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class HomePage extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar:CustomAppBar(
        title: 'BIJAK',
        leadingIcon: Icons.person,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              // Implement logout functionality
            },
            padding: const EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: homeController.isLoading.value ? buildShimmer() : buildContent(screenWidth ,context),
      floatingActionButton: Visibility(
        visible: homeController.cartItems.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () async {
            var result = await Get.to(() => CartPage(cartItems: homeController.cartItems));
            if (result != null) {
                homeController.cartItems.value = result;
              homeController.saveCartData();
            }
          }, child: const Icon(Icons.shopping_cart),),
      ),
    ));
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView(
        children: [
          // Shimmer layout similar to the content layout
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

  Widget buildContent(double width,BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        children: [
          // Search Bar
          searchBar(),

          // Image Banners
          imageBanner(width),

          // Categories
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Categories', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          buildCategories(height),

          // Recently Ordered
          const Padding(
            padding: EdgeInsets.only(top: 16.0, right: 16.0,left: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Recently Ordered', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          buildRecentOrder(height,width),

          // Seasonal Products
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Seasonal Products', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          buildSeasonalProduct(),

          SizedBox(height: height/8),

        ],
      ),
    );


  }

  Widget searchBar(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search Here',
          hintStyle: const TextStyle(fontSize: 14.0, color: Colors.grey ,fontFamily: 'regular'),
          prefixIcon: const Icon(Icons.search, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black, width: 1.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget imageBanner(double width){
    return  SizedBox(
      height: width * 2 / 3,
      child: PageView.builder(
        controller: homeController.pageController,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset('assets/images/banner${index + 1}.jpeg', fit: BoxFit.cover),
          );
        },
      ),
    );
  }

  Widget buildCategories(double height){
    return SizedBox(
      height: height/8,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: homeController.categories.length,
        itemBuilder: (context, index) {
          final category = homeController.categories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 24.0,
                  backgroundImage: AssetImage(category.products[0].image),
                ),
                const SizedBox(height: 8.0),
                Text(
                  category.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRecentOrder(double height, double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: homeController.recentlyOrdered.map((product) {
          bool isInCart = homeController.cartItems.any((item) => item.id == product.id);
          int cartQuantity = isInCart ? homeController.cartItems.firstWhere((item) => item.id == product.id).quantity : 0;
          return GestureDetector(
            onTap: () async {
              var result = await Get.to(() => ProductDetailPage(product: product), transition: Transition.rightToLeftWithFade);
              if (result != null) {
                homeController.cartItems.value = result;
                homeController.saveCartData();
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,left:8.0 ,right: 8.0),
              child: Container(
                width: width / 3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 3.0)],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(product.image, height: 96.0, width: double.infinity, fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontSize: 12.0), maxLines: 1),
                          Text(product.weight, style: const TextStyle(fontSize: 10.0, color: Colors.grey)),
                          Text('\$${product.price}', style: const TextStyle(fontSize: 10.0, color: Colors.grey)),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: isInCart ?IncrementDecrementRow(
                              cartQuantity: cartQuantity,
                              onIncrement: () => homeController.addToCart(product),
                              onDecrement: () => homeController.removeFromCart(product),
                            ):AddToCartButton(
                              onPressed: () => homeController.addToCart(product),
                            ),
                          ),
                          // isInCart
                          //     ? Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     IconButton(
                          //       icon: const Icon(Icons.remove),
                          //       onPressed: () {
                          //         homeController.removeFromCart(product);
                          //       },
                          //     ),
                          //     Text('$cartQuantity'),
                          //     IconButton(
                          //       icon: const Icon(Icons.add),
                          //       onPressed: () {
                          //         homeController.addToCart(product);
                          //       },
                          //     ),
                          //   ],
                          // )
                          //     : Align(
                          //   alignment: Alignment.bottomCenter,
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       homeController.addToCart(product);
                          //     },
                          //     child: const AutoSizeText('Add to cart', maxLines: 1),
                          //   ),
                          // ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildSeasonalProduct(){
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: homeController.seasonalProducts.length,
      itemBuilder: (context, index) {
        final product = homeController.seasonalProducts[index];
        bool isInCart = homeController.cartItems.any((item) => item.id == product.id);
        int cartQuantity = isInCart ? homeController.cartItems.firstWhere((item) => item.id == product.id).quantity : 0;
        return GestureDetector(
          onTap: () async{
            var result = await Get.to(()=>ProductDetailPage(product: product),transition: Transition.rightToLeftWithFade);
            if(result!=null){
              homeController.cartItems.value = result;
              homeController.saveCartData();
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [const BoxShadow(color: Colors.grey, blurRadius: 3.0)],
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(product.image, height: 96.0, width: 96.0, fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name, style: const TextStyle(fontSize: 12.0), maxLines: 1),
                          Text(product.weight, style: const TextStyle(fontSize: 10.0, color: Colors.grey)),
                          Text('\$${product.price}', style: const TextStyle(fontSize: 10.0, color: Colors.grey)),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: isInCart ?IncrementDecrementRow(
                              cartQuantity: cartQuantity,
                              onIncrement: () => homeController.addToCart(product),
                              onDecrement: () => homeController.removeFromCart(product),
                            ):AddToCartButton(
                              onPressed: () => homeController.addToCart(product),
                            ),
                          ),

                          // isInCart?
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: Row(
                          //     mainAxisSize: MainAxisSize.min,
                          //     children: [
                          //       IconButton(
                          //         icon: const Icon(Icons.remove),
                          //         onPressed: () {
                          //           homeController.removeFromCart(product);
                          //         },
                          //       ),
                          //       Text('$cartQuantity'),
                          //       IconButton(
                          //         icon: const Icon(Icons.add),
                          //         onPressed: () {
                          //           homeController.addToCart(product);
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ):
                          // Align(
                          //   alignment: Alignment.bottomRight,
                          //   child: ElevatedButton(
                          //     onPressed: () { homeController.addToCart(product);},
                          //     child: const AutoSizeText('Add to cart',maxLines: 1,),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}



