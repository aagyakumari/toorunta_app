import 'package:toorunta_mobile/features/map/model/product.dart';
import 'package:toorunta_mobile/features/map/service/product_service.dart';

class ProductRepository {
  final ProductService _productService;

  ProductRepository({ProductService? productService})
      : _productService = productService ?? ProductService();

  Future<List<Product>> getNearbyProducts() async {
    try {
      final products = await _productService.getNearbyProducts();
      
      // Sort products by distance
      products.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
      
      return products;
    } catch (e) {
      // For development, return mock data if API fails
      return _getMockProducts();
    }
  }

  List<Product> _getMockProducts() {
    return [
      Product(
        id: 101,
        name: "Organic Apples",
        price: 3.99,
        image: "assets/images/product1.jpg", // Using local image as fallback
        vendor: "Green Farm",
        location: ProductLocation(lat: 53.8008, lng: -1.5491),
        category: "groceries",
        rating: 4.5,
        distanceKm: 1.2,
      ),
      Product(
        id: 102,
        name: "Fresh Salmon",
        price: 12.50,
        image: "assets/images/product2.jpg", // Using local image as fallback
        vendor: "CleckFish Market",
        location: ProductLocation(lat: 53.8020, lng: -1.5480),
        category: "fishmonger",
        rating: 4.7,
        distanceKm: 0.8,
      ),
      Product(
        id: 103,
        name: "Vintage Chair",
        price: 149.99,
        image: "assets/images/product3.jpg",
        vendor: "Antique House",
        location: ProductLocation(lat: 53.7990, lng: -1.5510),
        category: "furniture",
        rating: 4.3,
        distanceKm: 1.5,
      ),
      Product(
        id: 104,
        name: "Mountain Bike",
        price: 599.99,
        image: "assets/images/product4.jpg",
        vendor: "Sports Hub",
        location: ProductLocation(lat: 53.8040, lng: -1.5470),
        category: "sports",
        rating: 4.8,
        distanceKm: 0.5,
      ),
      Product(
        id: 105,
        name: "Coffee Machine",
        price: 299.99,
        image: "assets/images/product5.jpg",
        vendor: "Kitchen Plus",
        location: ProductLocation(lat: 53.8015, lng: -1.5520),
        category: "appliances",
        rating: 4.6,
        distanceKm: 0.9,
      ),
      Product(
        id: 106,
        name: "Gaming Laptop",
        price: 1299.99,
        image: "assets/images/product6.jpg",
        vendor: "Tech World",
        location: ProductLocation(lat: 53.7980, lng: -1.5500),
        category: "electronics",
        rating: 4.9,
        distanceKm: 1.7,
      ),
    ];
  }
} 