import 'package:dio/dio.dart';
import '../model/product.dart';

class ProductService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:8000/api/v1'));

  Future<List<Product>> fetchProducts({int page = 1, int perPage = 15}) async {
    try {
      final response = await _dio.get('/products', queryParameters: {
        'page': page,
        'per_page': perPage,
      });

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => Product.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      rethrow;
    }
  }
}
