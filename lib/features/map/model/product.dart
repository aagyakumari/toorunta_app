class ProductLocation {
  final double lat;
  final double lng;

  ProductLocation({
    required this.lat,
    required this.lng,
  });

  factory ProductLocation.fromJson(Map<String, dynamic> json) {
    return ProductLocation(
      lat: json['lat']?.toDouble() ?? 0.0,
      lng: json['lng']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }
}

class Product {
  final int id;
  final String name;
  final double price;
  final String image;
  final String vendor;
  final ProductLocation location;
  final String category;
  final double rating;
  final double distanceKm;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.vendor,
    required this.location,
    required this.category,
    required this.rating,
    required this.distanceKm,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      price: json['price']?.toDouble() ?? 0.0,
      image: json['image'] ?? '',
      vendor: json['vendor'] ?? '',
      location: ProductLocation.fromJson(json['location'] ?? {}),
      category: json['category'] ?? '',
      rating: json['rating']?.toDouble() ?? 0.0,
      distanceKm: json['distance_km']?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'vendor': vendor,
      'location': location.toJson(),
      'category': category,
      'rating': rating,
      'distance_km': distanceKm,
    };
  }
} 