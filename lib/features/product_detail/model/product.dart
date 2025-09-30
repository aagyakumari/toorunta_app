class Product {
  final String id;
  final String name;
  final double price;
  final String location;
  final String postedDate;
  final String condition;
  final String color;
  final String warranty;
  final String description;
  final double latitude;
  final double longitude;
  final String category; // Added category field

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.postedDate,
    required this.condition,
    required this.color,
    required this.warranty,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.category, // Add to constructor
  });

  static List<Product> sampleProducts = [
    Product(
      id: '1',
      name: 'iPhone 14 Pro Max',
      price: 999.00,
      location: 'Kathmandu, Nepal',
      postedDate: '2 days ago',
      condition: 'Like New',
      color: 'Deep Purple',
      warranty: '11 months remaining',
      description: 'Latest iPhone 14 Pro Max with 256GB storage, featuring Dynamic Island, 48MP camera system, and A16 Bionic chip. Includes original accessories and AppleCare+.',
      latitude: 27.7172,
      longitude: 85.3240,
      category: 'Mobile',
    ),
    Product(
      id: '2',
      name: 'MacBook Air M2',
      price: 1299.00,
      location: 'Pokhara, Nepal',
      postedDate: '3 days ago',
      condition: 'New',
      color: 'Midnight',
      warranty: '1 year international',
      description: 'Brand new M2 MacBook Air with 8-core CPU, 10-core GPU, 8GB unified memory, and 256GB SSD. Features liquid retina display and MagSafe charging.',
      latitude: 28.2096,
      longitude: 83.9856,
      category: 'Laptop',
    ),
    Product(
      id: '3',
      name: 'iPad Pro 12.9"',
      price: 1099.00,
      location: 'Lalitpur, Nepal',
      postedDate: '1 week ago',
      condition: 'Excellent',
      color: 'Space Gray',
      warranty: '6 months remaining',
      description: '12.9-inch iPad Pro with M2 chip, Liquid Retina XDR display, 256GB storage. Perfect for creative professionals. Includes Apple Pencil 2nd generation.',
      latitude: 27.6588,
      longitude: 85.3247,
      category: 'Tablet',
    ),
    Product(
      id: '4',
      name: 'AirPods Pro',
      price: 249.00,
      location: 'Bhaktapur, Nepal',
      postedDate: '5 days ago',
      condition: 'New',
      color: 'White',
      warranty: '1 year international',
      description: '2nd generation AirPods Pro with active noise cancellation, transparency mode, and personalized spatial audio. Includes MagSafe charging case.',
      latitude: 27.6710,
      longitude: 85.4298,
      category: 'Audio',
    ),
    Product(
      id: '5',
      name: 'Apple Watch Series 8',
      price: 399.00,
      location: 'Kathmandu, Nepal',
      postedDate: '1 day ago',
      condition: 'Like New',
      color: 'Starlight',
      warranty: '10 months remaining',
      description: 'Series 8 GPS model with 45mm aluminum case, featuring temperature sensing, crash detection, and advanced health monitoring.',
      latitude: 27.7052,
      longitude: 85.3144,
      category: 'Wearable',
    ),
    Product(
      id: '6',
      name: 'iMac 24"',
      price: 1299.00,
      location: 'Pokhara, Nepal',
      postedDate: '4 days ago',
      condition: 'New',
      color: 'Blue',
      warranty: '1 year international',
      description: '24-inch iMac with M1 chip, 4.5K Retina display, 8-core CPU, 8-core GPU, 8GB RAM, and 256GB SSD. Includes Magic Keyboard and Magic Mouse.',
      latitude: 28.2037,
      longitude: 83.9735,
      category: 'Desktop',
    ),
    Product(
      id: '7',
      name: 'Mac mini M2',
      price: 599.00,
      location: 'Lalitpur, Nepal',
      postedDate: '6 days ago',
      condition: 'New',
      color: 'Silver',
      warranty: '1 year international',
      description: 'M2 Mac mini with 8-core CPU, 10-core GPU, 8GB unified memory, and 256GB SSD. Perfect for home office or development setup.',
      latitude: 27.6700,
      longitude: 85.3167,
      category: 'Desktop',
    ),
    Product(
      id: '8',
      name: 'Magic Keyboard',
      price: 299.00,
      location: 'Bhaktapur, Nepal',
      postedDate: '3 days ago',
      condition: 'New',
      color: 'White',
      warranty: '1 year international',
      description: 'Magic Keyboard with Touch ID and Numeric Keypad. Compatible with Mac computers with Apple silicon. Features comfortable, precise typing experience.',
      latitude: 27.6725,
      longitude: 85.4277,
      category: 'Accessory',
    ),
    Product(
      id: '9',
      name: 'Studio Display',
      price: 1599.00,
      location: 'Kathmandu, Nepal',
      postedDate: '1 week ago',
      condition: 'New',
      color: 'Silver',
      warranty: '1 year international',
      description: '27-inch 5K Retina display with 12MP Ultra Wide camera, studio-quality mics, and six-speaker sound system. Includes tilt-adjustable stand.',
      latitude: 27.7147,
      longitude: 85.3155,
      category: 'Monitor',
    ),
  ];

  static Product getById(String id) {
    return sampleProducts.firstWhere(
      (product) => product.id == id,
      orElse: () => sampleProducts[0],
    );
  }
}
