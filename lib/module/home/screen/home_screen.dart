// home_page.dart

import 'dart:async';
import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/controller/home_controller.dart';
import 'package:bijak_app/module/home/screen/cart_page.dart';
import 'package:bijak_app/module/home/screen/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Obx(() => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
          padding: EdgeInsets.only(left: 16.0),
        ),
        title: Text('App Name', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {},
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: homeController.isLoading.value ? buildShimmer() : buildContent(screenWidth),
      floatingActionButton: Visibility(
        visible: homeController.cartItems.isNotEmpty,
        child: FloatingActionButton(
          onPressed: () async {
            var result = await Get.to(() => CartPage(cartItems: homeController.cartItems));
            print(result);
            if (result != null) {
                homeController.cartItems.value = result;
              homeController.saveCartData();
            }
          }, child: Icon(Icons.shopping_cart),),
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
          SizedBox(height: 16.0),
          buildShimmerContainer(height: 150.0),
          SizedBox(height: 16.0),
          buildShimmerContainer(height: 50.0),
          SizedBox(height: 8.0),
          buildShimmerContainer(height: 100.0, isHorizontalList: true),
          SizedBox(height: 16.0),
          buildShimmerContainer(height: 50.0),
          SizedBox(height: 8.0),
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
          ? EdgeInsets.symmetric(vertical: 8.0)
          : EdgeInsets.symmetric(horizontal: 16.0),
    );
  }

  Widget buildContent(double screenWidth) {
    var height = MediaQuery.of(context).size.height;
    print("height ${height}");
    return SingleChildScrollView(
      child: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Here',
                hintStyle: TextStyle(fontSize: 14.0, color: Colors.grey),
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),

          // Image Banners
          Container(
            height: screenWidth * 2 / 3,
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
          ),

          // Categories
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Categories', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
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
                      SizedBox(height: 8.0),
                      Text(
                        category.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Recently Ordered
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Recently Ordered', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          Container(
            height: height/3.5,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: homeController.recentlyOrdered.length,
              itemBuilder: (context, index) {
                final product = homeController.recentlyOrdered[index];
                bool isInCart = homeController.cartItems.any((item) => item.id == product.id);
                int cartQuantity = isInCart ? homeController.cartItems.firstWhere((item) => item.id == product.id).quantity : 0;
                return GestureDetector(
                  onTap: ()async{
                      var result = await Get.to(()=>ProductDetailPage(product: product));
                      print("result ${result.toString()}");
                      if(result!=null){
                          homeController.cartItems.value = result;
                        homeController.saveCartData();
                      }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.0)],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(product.image, height: 96.0, width: double.infinity, fit: BoxFit.cover),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Text(product.name, style: TextStyle(fontSize: 12.0), maxLines: 1),
                                Text(product.weight, style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                                Text('\$${product.price}', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                                isInCart?
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        homeController.removeFromCart(product);
                                      },
                                    ),
                                    Text('${cartQuantity}'),
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        homeController.addToCart(product);
                                      },
                                    ),
                                  ],
                                ) :
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () { homeController.addToCart(product);},
                                    child: AutoSizeText('Add to cart',maxLines: 1,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Seasonal Products
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Seasonal Products', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
            ),
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: homeController.seasonalProducts.length,
            itemBuilder: (context, index) {
              final product = homeController.seasonalProducts[index];
              bool isInCart = homeController.cartItems.any((item) => item.id == product.id);
              int cartQuantity = isInCart ? homeController.cartItems.firstWhere((item) => item.id == product.id).quantity : 0;
              return GestureDetector(
                onTap: () async{
                  var result = await Get.to(()=>ProductDetailPage(product: product));
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
                      boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 3.0)],
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
                                Text(product.name, style: TextStyle(fontSize: 12.0), maxLines: 1),
                                Text(product.weight, style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                                Text('\$${product.price}', style: TextStyle(fontSize: 10.0, color: Colors.grey)),
                                isInCart?
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          homeController.removeFromCart(product);
                                        },
                                      ),
                                      Text('${cartQuantity}'),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          homeController.addToCart(product);
                                        },
                                      ),
                                    ],
                                  ),
                                ):
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: ElevatedButton(
                                    onPressed: () { homeController.addToCart(product);},
                                    child: AutoSizeText('Add to cart',maxLines: 1,),
                                  ),
                                ),
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
          ),

        ],
      ),
    );
  }
}



