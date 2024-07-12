// dummy_data.dart

class Product {
  final String name;
  final String weight;
  final String image;
  final double price;
  final String description;

  Product({
    required this.name,
    required this.weight,
    required this.image,
    required this.price,
    required this.description,
  });
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
        name: 'Tomato',
        weight: '1 kg',
        image: 'assets/images/tomato.jpg',
        price: 1.5,
        description: 'Fresh red tomatoes',
      ),
      Product(
        name: 'Potato',
        weight: '1 kg',
        image: 'assets/images/potato.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
        name: 'Carrot',
        weight: '1 kg',
        image: 'assets/images/carrot.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
        name: 'Cabbage',
        weight: '1 kg',
        image: 'assets/images/cabbage.jpeg',
        price: 1.2,
        description: 'Fresh potatoes',
      ),
      Product(
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
        name: 'Apple',
        weight: '1 kg',
        image: 'assets/images/apple.jpg',
        price: 3.0,
        description: 'Fresh red apples',
      ),
      Product(
        name: 'Banana',
        weight: '1 dozen',
        image: 'assets/images/banana.jpg',
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
        name: 'Orange Juice',
        weight: '1 litre',
        image: 'assets/images/orange_juice.jpg',
        price: 4.0,
        description: 'Freshly squeezed orange juice',
      ),
      Product(
        name: 'Apple Juice',
        weight: '1 litre',
        image: 'assets/images/apple_juice.jpg',
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
        name: 'Fruit Combo',
        weight: '3 kg',
        image: 'assets/images/fruit_combo.jpg',
        price: 10.0,
        description: 'A combo of fresh fruits',
      ),
      Product(
        name: 'Vegetable Combo',
        weight: '3 kg',
        image: 'assets/images/vegetable_combo.jpg',
        price: 8.0,
        description: 'A combo of fresh vegetables',
      ),
      // Add 3 more combo products here
    ],
  ),
  Category(
    name: 'Pure Produced Items',
    products: [
      Product(
        name: 'Pure Honey',
        weight: '500 g',
        image: 'assets/images/honey.jpg',
        price: 6.0,
        description: 'Pure natural honey',
      ),
      Product(
        name: 'Pure Ghee',
        weight: '1 kg',
        image: 'assets/images/ghee.jpg',
        price: 20.0,
        description: 'Pure desi ghee',
      ),
      // Add 3 more pure produced items here
    ],
  ),
];
