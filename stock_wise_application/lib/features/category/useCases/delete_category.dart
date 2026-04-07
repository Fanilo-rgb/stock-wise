import 'package:stock_wise_application/features/category/data/repositories/category_repository.dart';

class DeleteCategory {
  final CategoryRepository _repository;

  DeleteCategory(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteCategory(id);
  }
}
