import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final Box<ProductModel> _box;

  ProductRepositoryImpl(this._box);

  @override
  List<ProductModel> getAllProducts() => _box.values.toList();

  @override
  ProductModel? getProductById(String id) => _box.get(id);

  @override
  Future<void> saveProduct(ProductModel product) async {
    await _box.put(product.id, product);
  }

  @override
  Future<void> deleteProduct(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clearAll() async => await _box.clear();
}
