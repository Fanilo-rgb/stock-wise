import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/data/repositories/category_repository_implementation.dart';

Future<void> testCategories() async {
  final repository = CategoryRepositoryImplementation(
    Hive.box<CategoryModel>('categories'),
  );

  await repository.clearAll();

  debugPrint('\n========== CATEGORIES ==========');

  // CREATE
  final cats = [
    CategoryModel(
      id: 'cat1',
      name: 'Nourriture',
      iconPath: 'assets/icons/green-salad.svg',
    ),
    CategoryModel(
      id: 'cat2',
      name: 'Hygiène',
      iconPath: 'assets/icons/soap.svg',
    ),
    CategoryModel(
      id: 'cat3',
      name: 'Entretien',
      iconPath: 'assets/icons/water-bottle-glass.svg',
    ),
    CategoryModel(
      id: 'cat4',
      name: 'Energie',
      iconPath: 'assets/icons/gas-propane.svg',
    ),
  ];
  for (final cat in cats) {
    await repository.saveCategory(cat);
  }
  debugPrint(
    ' CREATE → ${repository.getAllCategories().length} catégories ajoutées',
  );

  // READ
  debugPrint('\n READ toutes les catégories :');
  for (final cat in repository.getAllCategories()) {
    debugPrint('   - [${cat.id}] ${cat.name} | icon: ${cat.iconPath}');
  }

  // UPDATE
  final cat1 = repository.getCategoryById("cat1");

  if (cat1 != null) {
    cat1.name = 'Alimentation';
    await cat1.save();
    debugPrint(
      '\n  UPDATE → cat1 renommée en "${repository.getCategoryById("cat1")!.name}"',
    );
  }

  // DELETE
  await repository.deleteCategory("cat4");
  debugPrint(
    '  DELETE → cat4 supprimée, reste ${repository.getAllCategories().length} catégories',
  );
}
