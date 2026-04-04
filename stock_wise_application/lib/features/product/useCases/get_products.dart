import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository _repository;

  GetProducts(this._repository);

  List<ProductModel> call() => _repository.getAllProducts();
}
