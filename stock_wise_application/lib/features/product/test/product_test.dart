import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/core/result/result.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository_impl.dart';
import 'package:stock_wise_application/features/product/useCases/delete_product.dart';
import 'package:stock_wise_application/features/product/useCases/get_expiring_products.dart';
import 'package:stock_wise_application/features/product/useCases/get_low_stock_products.dart';
import 'package:stock_wise_application/features/product/useCases/get_product_details.dart';
import 'package:stock_wise_application/features/product/useCases/get_products.dart';
import 'package:stock_wise_application/features/product/useCases/reset_product.dart';
import 'package:stock_wise_application/features/product/useCases/save_product.dart';
import 'package:stock_wise_application/features/product/useCases/update_product_quantity.dart';

Future<void> testProducts() async {
  final repository = ProductRepositoryImpl(Hive.box<ProductModel>('products'));

  final saveProduct = SaveProduct(repository);
  final getProducts = GetProducts(repository);
  final getLowStock = GetLowStockProducts(repository);
  final updateQuantity = UpdateProductQuantity(repository);
  final getProductDetails = GetProductDetails(repository);
  final getExpiring = GetExpiringProducts(repository);
  final deleteProduct = DeleteProduct(repository);
  final resetProduct = ResetProduct(repository);

  await resetProduct.call();

  debugPrint('\n========== PRODUCTS ==========');

  // CREATE
  final products = [
    ProductModel(
      id: 'prod1',
      name: 'Riz',
      categoryId: 'cat1',
      locationId: 'loc4', // Cuisine › Placard
      quantity: 5,
      unit: 'kg',
      minQuantity: 1,
    ),
    ProductModel(
      id: 'prod2',
      name: 'Beurre',
      categoryId: 'cat1',
      locationId: 'loc3', // Cuisine › Frigo
      quantity: 2,
      unit: 'pièce',
      minQuantity: 1,
      expiryDate: DateTime(2026, 5, 1),
    ),
    ProductModel(
      id: 'prod3',
      name: 'Savon',
      categoryId: 'cat2',
      locationId: 'loc5', // Salle de bain › Armoire
      quantity: 3,
      unit: 'pièce',
      minQuantity: 1,
      barcode: '3017620422003',
    ),
  ];

  for (final p in products) {
    await saveProduct.call(p);
  }
  debugPrint(' CREATE → ${getProducts.call().length} produits ajoutés');

  // READ
  debugPrint('\n READ tous les produits :');
  for (final p in getProducts.call()) {
    debugPrint(
      '   - [${p.id}] ${p.name} | qty: ${p.quantity} ${p.unit} | barcode: ${p.barcode ?? "aucun"}',
    );
  }

  // READ — produits critiques (quantity <= minQuantity)
  final lowStock = getLowStock.call();
  debugPrint('\nLOW STOCK: ${lowStock.length}');
  for (final p in lowStock) {
    debugPrint('  - ${p.name} -> ${p.quantity} ${p.unit} remaining');
  }

  // UPDATE quantité
  final result = await updateQuantity.call('prod1', 0.5);

  switch (result) {
    case Success():
      debugPrint("Quantity updated");
    case Failure(:final message):
      debugPrint("Error: $message");
  }

  debugPrint(
    '\n  UPDATE → Riz quantité mise à ${repository.getProductById('prod1')!.quantity} kg',
  );

  // Vérifie si critique après update
  final rizUpdated = getProductDetails.call("prod1")!;
  debugPrint(
    '   → Critique ? ${rizUpdated.quantity <= rizUpdated.minQuantity ? "OUI" : "NON"}',
  );

  // READ — produits bientôt périmés (dans les 30 prochains jours)
  final expiring = getExpiring.call(); // clean
  debugPrint('\nEXPIRING SOON: ${expiring.length}');
  for (final p in expiring) {
    debugPrint('  - ${p.name} -> expires ${p.expiryDate}');
  }

  // DELETE
  await deleteProduct.call('prod3');
  debugPrint(
    '\n  DELETE → prod3 supprimé, reste ${getProducts.call().length} produits',
  );

  // reset le tout pour le prochain test
  await resetProduct.call();
}
