import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetLowStockProducts {
  final ProductRepository _repository;
  GetLowStockProducts(this._repository);

  List<ProductModel> call() {
    final products = _repository.getAllProducts();
    return products.where((p) => p.quantity <= p.minQuantity).toList();
  }
}
