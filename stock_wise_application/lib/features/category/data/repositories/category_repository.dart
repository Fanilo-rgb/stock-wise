import 'package:stock_wise_application/features/category/data/models/category_model.dart';

abstract class CategoryRepository {
  List<CategoryModel> getAllCategories();
  CategoryModel? getCategoryById(String id);
  Future<void> saveCategory(CategoryModel category);
  Future<void> deleteCategory(String id);
  Future<void> clearAll();
}
