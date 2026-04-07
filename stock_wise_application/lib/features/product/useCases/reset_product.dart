import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class ResetProduct {
  final ProductRepository _repository;

  ResetProduct(this._repository);

  Future<void> call() async {
    await _repository.clearAll();
  }
}
