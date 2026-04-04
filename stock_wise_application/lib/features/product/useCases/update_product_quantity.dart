import 'package:stock_wise_application/core/result/result.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class UpdateProductQuantity {
  final ProductRepository _repository;
  UpdateProductQuantity(this._repository);

  Future<Result<void>> call(String id, double newQuantity) async {
    final product = _repository.getProductById(id);
    if (product == null) return const Failure("Produit introuvable");

    if (newQuantity < 0) {
      return const Failure("La quantité ne peut pas être négative");
    }

    product.quantity = newQuantity;
    await _repository.saveProduct(product);
    return const Success(null);
  }
}
