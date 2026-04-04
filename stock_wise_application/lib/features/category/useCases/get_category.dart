import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/data/repositories/category_repository.dart';

class GetCategory {
  final CategoryRepository _repository;

  GetCategory(this._repository);

  CategoryModel? call(String categoryId) =>
      _repository.getCategoryById(categoryId);
}
