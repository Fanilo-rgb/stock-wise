import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetExpiringProducts {
  final ProductRepository _repository;

  GetExpiringProducts(this._repository);

  List<ProductModel> call({int withinDays = 30}) {
    final deadline = DateTime.now().add(Duration(days: withinDays));

    return _repository
        .getAllProducts()
        .where((p) => p.expiryDate != null && p.expiryDate!.isBefore(deadline))
        .toList();
  }
}
