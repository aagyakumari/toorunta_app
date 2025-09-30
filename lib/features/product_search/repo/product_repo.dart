import '../model/product.dart';
import '../service/product_service.dart';

class ProductRepository {
  final ProductService _service = ProductService();

  Future<List<Product>> getProducts({int page = 1, int perPage = 15}) async {
    return await _service.fetchProducts(page: page, perPage: perPage);
  }
}
