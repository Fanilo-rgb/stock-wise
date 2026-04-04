import 'package:stock_wise_application/features/category/data/repositories/category_repository.dart';

class ResetCategory {
  final CategoryRepository _repository;

  ResetCategory(this._repository);

  Future<void> call() async => await _repository.clearAll();
}
