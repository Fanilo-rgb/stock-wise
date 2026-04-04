import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class DeleteProduct {
  final ProductRepository _repository;
  DeleteProduct(this._repository);

  Future<void> call(String id) async => await _repository.deleteProduct(id);
}
