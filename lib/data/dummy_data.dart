// dummy_data.dart

class Product {
  final int id;
  final String name;
  final String weight;
  final String image;
  final double price;
  final String description;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.weight,
    required this.image,
    required this.price,
    required this.description,
    this.quantity=0,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      weight: json['weight'],
      image: json['image'],
      price: json['price'],
      description: json['description'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'image': image,
      'price': price,
      'description': description,
      'quantity': quantity,
    };
  }
}

class Category {
  final String name;
  final List<Product> products;

  Category({
    required this.name,
    required this.products,
  });
}

List<Category> dummyData = [
  Category(
    name: 'Vegetables',
    products: [
      Product(
        id: 1,
        name: 'Tomato',
        weight: '1 kg',
        image: 'assets/images/tomato.jpg',
        price: 1.5,
        description: 'Fresh red tomatoes',
      ),
      Product(
        id: 2,
        name: 'Potato',
        weight: '1 kg',
        image: 'assets/images/potato.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
        id: 3,
        name: 'Carrot',
        weight: '1 kg',
        image: 'assets/images/carrot.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
        id: 4,
        name: 'Cabbage',
        weight: '1 kg',
        image: 'assets/images/cabbage.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
        id: 5,
        name: 'Spinach',
        weight: '1 kg',
        image: 'assets/images/spinach.jpg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      // Add 3 more vegetable products here
    ],
  ),
  Category(
    name: 'Fruits',
    products: [
      Product(
        id: 6,
        name: 'Apple',
        weight: '1 kg',
        image: 'assets/images/apple.jpg',
        price: 3.0,
        description: 'Fresh red apples',
      ),
      Product(
        id: 7,
        name: 'Banana',
        weight: '1 dozen',
        image: 'assets/images/banana.jpeg',
        price: 2.5,
        description: 'Fresh bananas',
      ),
      Product(
        id: 8,
        name: 'Blueberry',
        weight: '1 dozen',
        image: 'assets/images/blueberry.jpg',
        price: 2.5,
        description: 'Fresh bananas',
      ),
      Product(
        id: 9,
        name: 'Mango',
        weight: '1 dozen',
        image: 'assets/images/mango.jpeg',
        price: 2.5,
        description: 'Fresh bananas',
      ), Product(
        id: 10,
        name: 'Strawberry',
        weight: '1 dozen',
        image: 'assets/images/strawberry.jpg',
        price: 2.5,
        description: 'Fresh bananas',
      ),
      // Add 3 more fruit products here
    ],
  ),
  Category(
    name: 'Fresh Juice Items',
    products: [
      Product(
        id: 11,
        name: 'Orange Juice',
        weight: '1 litre',
        image: 'assets/images/orange_juice.jpg',
        price: 4.0,
        description: 'Freshly squeezed orange juice',
      ),
      Product(
        id: 12,
        name: 'Apple Juice',
        weight: '1 litre',
        image: 'assets/images/apple_juice.jpeg',
        price: 4.5,
        description: 'Freshly squeezed apple juice',
      ),
      // Add 3 more juice products here
    ],
  ),
  Category(
    name: 'Combos',
    products: [
      Product(
        id: 13,
        name: 'Fruit Combo',
        weight: '3 kg',
        image: 'assets/images/fruit_combo.jpeg',
        price: 10.0,
        description: 'A combo of fresh fruits',
      ),
      // Product(
      //   id: 11,
      //   name: 'Vegetable Combo',
      //   weight: '3 kg',
      //   image: 'assets/images/vegetable_combo.jpg',
      //   price: 8.0,
      //   description: 'A combo of fresh vegetables',
      // ),
      // Add 3 more combo products here
    ],
  ),
  Category(
    name: 'Pure Produced Items',
    products: [
      Product(
        id: 14,
        name: 'Pure Honey',
        weight: '500 g',
        image: 'assets/images/honey.jpg',
        price: 6.0,
        description: 'Pure natural honey',
      ),
      // Product(
      //   id: 13,
      //   name: 'Pure Ghee',
      //   weight: '1 kg',
      //   image: 'assets/images/ghee.jpg',
      //   price: 20.0,
      //   description: 'Pure desi ghee',
      // ),
      // Add 3 more pure produced items here
    ],
  ),
];
