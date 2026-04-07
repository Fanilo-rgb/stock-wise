import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/category/data/models/category_model.dart';
import 'package:stock_wise_application/features/category/data/repositories/category_repository_implementation.dart';
import 'package:stock_wise_application/features/category/useCases/get_categories.dart';
import 'package:stock_wise_application/features/category/useCases/get_category.dart';
import 'package:stock_wise_application/features/category/useCases/reset_category.dart';
import 'package:stock_wise_application/features/category/useCases/save_category.dart';
import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository_impl.dart';
import 'package:stock_wise_application/features/location/useCases/get_location_tree.dart';
import 'package:stock_wise_application/features/location/useCases/get_locations.dart';
import 'package:stock_wise_application/features/location/useCases/reset_location.dart';
import 'package:stock_wise_application/features/location/useCases/save_location.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository_impl.dart';
import 'package:stock_wise_application/features/product/useCases/get_product_details.dart';
import 'package:stock_wise_application/features/product/useCases/get_products.dart';
import 'package:stock_wise_application/features/product/useCases/reset_product.dart';
import 'package:stock_wise_application/features/product/useCases/save_product.dart';

Future<void> productDetailsTest() async {
  final productRepo = ProductRepositoryImpl(Hive.box<ProductModel>('products'));

  final categoryRepo = CategoryRepositoryImplementation(
    Hive.box<CategoryModel>('categories'),
  );

  final locationRepo = LocationRepositoryImpl(
    Hive.box<LocationModel>('locations'),
  );

  final saveProduct = SaveProduct(productRepo);
  final getProducts = GetProducts(productRepo);
  final getProductDetails = GetProductDetails(productRepo);

  final saveCategory = SaveCategory(categoryRepo);
  final getCategories = GetCategories(categoryRepo);
  final getCategory = GetCategory(categoryRepo);

  final saveLocation = SaveLocation(locationRepo);
  final getLocations = GetLocations(locationRepo);
  final getLocationTree = GetLocationTree(locationRepo);

  final resetProduct = ResetProduct(productRepo);
  final resetCategory = ResetCategory(categoryRepo);
  final resetLocation = ResetLocation(locationRepo);

  // creation des emplacements
  final cuisine = LocationModel(id: 'loc1', name: 'Cuisine');
  await saveLocation.call(cuisine);

  final frigo = LocationModel(id: 'loc2', name: 'Frigo', parentId: 'loc1');
  await saveLocation.call(frigo);

  debugPrint('CREATE → ${getLocations.call().length} locations ajoutées');

  // creation d'une categorie

  final food = CategoryModel(
    id: 'cat1',
    name: 'Nourriture',
    iconPath: 'assets/icons/green-salad.svg',
  );

  await saveCategory.call(food);
  debugPrint(' CREATE → ${getCategories.call().length} catégories ajoutées');

  // creation du produit

  final butter = ProductModel(
    id: 'prod1',
    name: 'Beurre',
    categoryId: 'cat1',
    locationId: 'loc2', // Cuisine › Frigo
    quantity: 2,
    unit: 'pièce',
    minQuantity: 1,
    expiryDate: DateTime(2026, 5, 1),
  );

  await saveProduct.call(butter);

  debugPrint(' CREATE → ${getProducts.call().length} produits ajoutés');

  // get product details

  final productId = "prod1";

  final product = getProductDetails.call(productId);

  if (product == null) {
    debugPrint('Product with id $productId not found');
    return;
  }

  final productCategory = getCategory.call(product.categoryId);

  final productLocation = getLocationTree.call(product.locationId);

  debugPrint('\n DETAILS du produit [${product.id}] ${product.name} :');
  debugPrint('   - Quantité : ${product.quantity} ${product.unit}');
  debugPrint('   - Catégorie : ${productCategory?.name ?? "inconnue"}');
  debugPrint(
    '   - Emplacement : ${productLocation.map((l) => l.name).join(" › ")}',
  );
  debugPrint(
    '   - Date de péremption : ${product.expiryDate != null ? "${product.expiryDate!.day}/${product.expiryDate!.month}/${product.expiryDate!.year}" : "aucune"}',
  );
  debugPrint("  - Expire dans : ${product.daysUntilExpiry}");

  // reset le tout pour le prochain test
  await resetProduct.call();
  await resetCategory.call();
  await resetLocation.call();
}
