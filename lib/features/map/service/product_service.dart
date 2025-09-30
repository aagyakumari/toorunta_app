import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toorunta_mobile/features/map/model/product.dart';

class ProductService {
  static const String _baseUrl = 'https://toorunta-products.beeceptor.com';

  Future<List<Product>> getNearbyProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products/nearby'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Product.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load nearby products: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load nearby products: $e');
    }
  }
} 