class Product {
  final int id;
  final String name;
  final double price;
  final String thumbnailUrl;
  final String location; // ✅ city + country

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.thumbnailUrl,
    required this.location,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final store = json['store'] ?? {};
    final city = store['city'] ?? '';
    final country = store['country'] ?? '';

    return Product(
      id: json['id'],
      name: json['name'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0,
      thumbnailUrl: json['thumbnail_url'] ?? '',
      location: [city, country].where((e) => e.isNotEmpty).join(', '), // ✅ Combine
    );
  }
}
