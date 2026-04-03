import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/category/data/models/category_model.dart';

Future<void> testCategories() async {
  final box = Hive.box<CategoryModel>('categories');
  await box.clear();

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
    await box.put(cat.id, cat);
  }
  debugPrint(' CREATE → ${box.length} catégories ajoutées');

  // READ
  debugPrint('\n📖 READ toutes les catégories :');
  for (final cat in box.values) {
    debugPrint('   - [${cat.id}] ${cat.name} | icon: ${cat.iconPath}');
  }

  // UPDATE
  final cat1 = box.get('cat1')!;
  cat1.name = 'Alimentation';
  await cat1.save();
  debugPrint('\n  UPDATE → cat1 renommée en "${box.get('cat1')!.name}"');

  // DELETE
  await box.delete('cat4');
  debugPrint('  DELETE → cat4 supprimée, reste ${box.length} catégories');
}
