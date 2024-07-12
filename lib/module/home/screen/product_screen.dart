import 'dart:convert';
import 'package:bijak_app/data/dummy_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> cartItems = [];

  @override
  void initState() {
    super.initState();
    _loadCartData();
  }

  Future<void> _loadCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? cartJson = prefs.getString('cartItems');
    if (cartJson != null) {
      List<dynamic> decodedCart = jsonDecode(cartJson);
      setState(() {
        cartItems = decodedCart.map((item) => Product.fromJson(item)).toList();
      });
    }
  }

  void _addToCart(Product product) {
    setState(() {
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
    });
    _saveCartData();
  }

  void _removeFromCart(Product product) {
    setState(() {
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
    });
    _saveCartData();
  }

  Future<void> _saveCartData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cartJson = jsonEncode(cartItems.map((item) => item.toJson()).toList());
    await prefs.setString('cartItems', cartJson);
  }

  int _getProductQuantity(Product product) {
    for (var item in cartItems) {
      if (item.id == product.id) {
        return item.quantity;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    int quantity = _getProductQuantity(widget.product);

    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            print("object");
            Get.back(result: cartItems);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.asset(widget.product.image, fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16.0),
                    topRight: Radius.circular(16.0),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8.0),
                    Text(
                      widget.product.name,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.product.description,
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      widget.product.weight,
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '\$${widget.product.price}',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (quantity > 0) ...[
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _removeFromCart(widget.product),
                          ),
                          Text('$quantity'),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _addToCart(widget.product),
                          ),
                        ] else ...[
                          ElevatedButton(
                            onPressed: () {
                              _addToCart(widget.product);
                              Get.snackbar('Cart', 'Item added to cart', snackPosition: SnackPosition.BOTTOM);
                            },
                            child: Text('Add to cart'),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
