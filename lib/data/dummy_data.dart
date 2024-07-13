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
    this.quantity = 0,
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
        description: 'Fresh red tomatoes, perfect for salads, sauces, and garnishing. '
            'These tomatoes are handpicked to ensure they are ripe and flavorful. '
            'Ideal for making pasta sauces, soups, and adding a burst of color to any dish.',
      ),
      Product(
        id: 2,
        name: 'Potato',
        weight: '1 kg',
        image: 'assets/images/potato.jpeg',
        price: 1.2,
        description: 'Fresh potatoes, ideal for frying, boiling, or baking. '
            'These versatile potatoes can be used to make a variety of dishes such as fries, mashed potatoes, and stews. '
            'They have a smooth texture and a rich, earthy flavor.',
      ),
      Product(
        id: 3,
        name: 'Carrot',
        weight: '1 kg',
        image: 'assets/images/carrot.jpeg',
        price: 1.2,
        description: 'Crunchy carrots, great for snacking, cooking, and juicing. '
            'Carrots are a rich source of beta-carotene, fiber, vitamin K1, and antioxidants. '
            'Perfect for adding to salads, stews, and as a healthy snack.',
      ),
      Product(
        id: 4,
        name: 'Cabbage',
        weight: '1 kg',
        image: 'assets/images/cabbage.jpeg',
        price: 1.2,
        description: 'Fresh cabbage, perfect for salads, stir-fries, and soups. '
            'Cabbage is packed with nutrients, including vitamin C, vitamin K, and fiber. '
            'Its crisp texture and slightly peppery flavor make it a versatile ingredient in many dishes.',
      ),
      Product(
        id: 5,
        name: 'Spinach',
        weight: '1 kg',
        image: 'assets/images/spinach.jpg',
        price: 1.2,
        description: 'Leafy spinach, ideal for salads, smoothies, and cooking. '
            'Spinach is rich in iron, vitamins A, C, and K, and antioxidants. '
            'Its tender leaves can be used in a variety of dishes, from fresh salads to warm sautés.',
      ),
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
        description: 'Fresh red apples, sweet and juicy. '
            'These apples are perfect for snacking, baking, and making applesauce. '
            'They are rich in fiber, vitamin C, and various antioxidants, making them a healthy choice.',
      ),
      Product(
        id: 7,
        name: 'Banana',
        weight: '1 dozen',
        image: 'assets/images/banana.jpeg',
        price: 2.5,
        description: 'Fresh bananas, rich in potassium and great for snacking. '
            'Bananas are a convenient and nutritious snack that can be eaten on their own or added to smoothies and desserts. '
            'They are also a good source of energy, making them a favorite among athletes.',
      ),
      Product(
        id: 8,
        name: 'Blueberry',
        weight: '500 g',
        image: 'assets/images/blueberry.jpg',
        price: 4.0,
        description: 'Fresh blueberries, perfect for smoothies, desserts, and snacking. '
            'Blueberries are high in fiber, vitamin C, vitamin K, and antioxidants. '
            'They are known for their sweet-tart flavor and are a delicious addition to a healthy diet.',
      ),
      Product(
        id: 9,
        name: 'Mango',
        weight: '1 kg',
        image: 'assets/images/mango.jpeg',
        price: 5.0,
        description: 'Juicy mangoes, full of tropical flavor. '
            'Mangoes are rich in vitamins A and C, as well as fiber. '
            'Their sweet, succulent flesh makes them a favorite for fresh eating, smoothies, and desserts.',
      ),
      Product(
        id: 10,
        name: 'Strawberry',
        weight: '500 g',
        image: 'assets/images/strawberry.jpg',
        price: 3.5,
        description: 'Fresh strawberries, sweet and delicious. '
            'Strawberries are an excellent source of vitamin C, manganese, and antioxidants. '
            'They are perfect for snacking, baking, and adding to salads and desserts.',
      ),
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
        description: 'Freshly squeezed orange juice, refreshing and healthy. '
            'This juice is packed with vitamin C and other essential nutrients. '
            'Perfect for a refreshing drink any time of the day.',
      ),
      Product(
        id: 12,
        name: 'Apple Juice',
        weight: '1 litre',
        image: 'assets/images/apple_juice.jpeg',
        price: 4.5,
        description: 'Freshly squeezed apple juice, delicious and nutritious. '
            'Apple juice is a good source of vitamins and minerals, including vitamin C and potassium. '
            'It is a refreshing drink that can be enjoyed any time.',
      ),
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
        description: 'A combo of fresh fruits, perfect for a healthy diet. '
            'This combo includes a variety of seasonal fruits that provide a range of nutrients and flavors. '
            'Ideal for families and health-conscious individuals.',
      ),
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
        description: 'Pure natural honey, rich in nutrients and great for health. '
            'This honey is unprocessed and retains all its natural goodness. '
            'It can be used as a natural sweetener, in cooking, or as a health supplement.',
      ),
    ],
  ),
];
