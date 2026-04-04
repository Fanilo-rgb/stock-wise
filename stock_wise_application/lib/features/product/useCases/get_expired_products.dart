import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetExpiredProducts {
  final ProductRepository _repository;

  GetExpiredProducts(this._repository);

  List<ProductModel> call() {
    return _repository
        .getAllProducts()
        .where(
          (p) => p.expiryDate != null && p.expiryDate!.isBefore(DateTime.now()),
        )
        .toList();
  }
}
