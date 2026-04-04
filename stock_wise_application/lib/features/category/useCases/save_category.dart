import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/data/repositories/category_repository.dart';

class SaveCategory {
  final CategoryRepository _repository;

  SaveCategory(this._repository);

  Future<void> call(CategoryModel category) =>
      _repository.saveCategory(category);
}
