// main.dart

import 'package:bijak_app/data/dummy_data.dart';
import 'package:bijak_app/module/home/controller/category_controller.dart';
import 'package:bijak_app/module/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    CategoryListScreen(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class CategoryListScreen extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Categories')),
      body: Obx(
            () {
          if (categoryController.categories.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: categoryController.categories.length,
              itemBuilder: (context, index) {
                final category = categoryController.categories[index];
                return ListTile(
                  title: Text(category.name),
                  onTap: () {
                    Get.to(() => ProductListScreen(category: category));
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class ProductListScreen extends StatelessWidget {
  final Category category;

  ProductListScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.name)),
      body: ListView.builder(
        itemCount: category.products.length,
        itemBuilder: (context, index) {
          final product = category.products[index];
          return ListTile(
            leading: Image.asset(product.image),
            title: Text(product.name),
            subtitle: Text('${product.weight} - \$${product.price}'),
            onTap: () {
              Get.to(() => ProductDetailScreen(product: product));
            },
          );
        },
      ),
    );
  }
}

class ProductDetailScreen extends StatelessWidget {
  final Product product;

  ProductDetailScreen({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(product.image),
            SizedBox(height: 16.0),
            Text(product.name, style: TextStyle(fontSize: 24.0)),
            Text('${product.weight} - \$${product.price}', style: TextStyle(fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text(product.description),
          ],
        ),
      ),
    );
  }
}
