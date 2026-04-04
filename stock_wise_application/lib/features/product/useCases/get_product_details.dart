import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetProductDetails {
  final ProductRepository _repository;

  GetProductDetails(this._repository);

  ProductModel? call(String productId) => _repository.getProductById(productId);
}
