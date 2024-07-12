// home_page.dart

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  Timer? _timer;
  bool _isLoading = true;
  List<Category> categories = [];
  List<Product> recentlyOrdered = [];
  List<Product> seasonalProducts = [];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
    // Simulate a delay to fetch data
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        _isLoading = false;
        categories = dummyData;
        recentlyOrdered = dummyData.expand((category) => category.products).take(5).toList();
        seasonalProducts = dummyData.expand((category) => category.products).take(5).toList();
      });
    });

  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }


  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        int nextPage = (_pageController.page?.round() ?? 0) + 1;
        if (nextPage >= 3) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
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
      body: _isLoading ? buildShimmer() : buildContent(screenWidth),
    );
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
              controller: _pageController,
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
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
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
              itemCount: recentlyOrdered.length,
              itemBuilder: (context, index) {
                final product = recentlyOrdered[index];
                return Padding(
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
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: AutoSizeText('Add to cart',maxLines: 1,),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
            itemCount: seasonalProducts.length,
            itemBuilder: (context, index) {
              final product = seasonalProducts[index];
              return Padding(
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
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Add to cart'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
