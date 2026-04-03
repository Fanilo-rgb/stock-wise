import 'package:stock_wise_application/core/result/result.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class ProductUseCases {
  final ProductRepository _repository;

  ProductUseCases(this._repository);

  int get length => _repository.getAllProducts().length;

  List<ProductModel> get products => _repository.getAllProducts();

  ProductModel? getProductById(String id) => _repository.getProductById(id);

  List<ProductModel> getLowStock() {
    return products.where((p) => p.quantity <= p.minQuantity).toList();
  }

  List<ProductModel> getExpiring({int withinDays = 30}) {
    final deadline = DateTime.now().add(Duration(days: withinDays));
    return products
        .where((p) => p.expiryDate != null && p.expiryDate!.isBefore(deadline))
        .toList();
  }

  List<ProductModel> getProductsByCategoryId(String categoryId) {
    return products.where((p) => p.categoryId == categoryId).toList();
  }

  Future<void> save(ProductModel product) async {
    await _repository.saveProduct(product);
  }

  Future<Result<void>> updateQuantity(String id, double newQuantity) async {
    final product = getProductById(id);

    if (product == null) return const Failure("Product not found");

    product.quantity = newQuantity;
    await save(product);
    return const Success(null);
  }

  Future<void> delete(String id) async {
    await _repository.deleteProduct(id);
  }

  Future<void> reset() async => await _repository.clearAll();
}
