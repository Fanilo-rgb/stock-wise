import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetProductsByCategory {
  final ProductRepository _repository;

  GetProductsByCategory(this._repository);

  List<ProductModel> call(String categoryId) => _repository
      .getAllProducts()
      .where((p) => p.categoryId == categoryId)
      .toList();
}
