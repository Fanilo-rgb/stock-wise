import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class SaveProduct {
  final ProductRepository _repository;

  SaveProduct(this._repository);

  Future<void> call(ProductModel product) async {
    await _repository.saveProduct(product);
  }
}
