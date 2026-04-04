import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository.dart';

class GetExpiringProducts {
  final ProductRepository _repository;

  GetExpiringProducts(this._repository);

  List<ProductModel> call({int withinDays = 30}) {
    return _repository.getAllProducts().where((p) {
      final days = p.daysUntilExpiry;
      return days != null && days >= 0 && days <= withinDays;
    }).toList();
  }
}
