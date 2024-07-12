// product_detail_page.dart

import 'package:bijak_app/data/dummy_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  ProductDetailPage({required this.product});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Detail', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height/2,
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 2 / 3,
                  child: Image.asset(product.image, fit: BoxFit.cover),
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
                      product.name,
                      style: TextStyle(fontSize: 12.0, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product.description,
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      product.weight,
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.0),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          // Add to cart logic
                          Get.snackbar('Cart', 'Item added to cart', snackPosition: SnackPosition.BOTTOM);
                        },
                        child: Text('Add to cart'),
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      '\$${product.price}',
                      style: TextStyle(fontSize: 10.0, color: Colors.grey),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
