import 'package:stock_wise_application/features/product/data/models/product_model.dart';

abstract class ProductRepository {
  List<ProductModel> getAllProducts();
  ProductModel? getProductById(String id);
  Future<void> saveProduct(ProductModel product);
  Future<void> deleteProduct(String id);
  Future<void> clearAll();
}
