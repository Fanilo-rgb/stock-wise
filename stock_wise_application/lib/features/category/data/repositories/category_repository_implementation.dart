import 'package:hive_flutter/adapters.dart';
import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/domain/repositories/category_repository.dart';

class CategoryRepositoryImplementation implements CategoryRepository {
  final Box<CategoryModel> _box;

  CategoryRepositoryImplementation(this._box);

  @override
  List<CategoryModel> getAllCategories() => _box.values.toList();

  @override
  CategoryModel? getCategoryById(String id) => _box.get(id);

  @override
  Future<void> saveCategory(CategoryModel category) async =>
      await _box.put(category.id, category);

  @override
  Future<void> deleteCategory(String id) async => await _box.delete(id);

  @override
  Future<void> clearAll() async => await _box.clear();
}
