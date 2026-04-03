import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/core/result/result.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';
import 'package:stock_wise_application/features/product/data/repositories/product_repository_impl.dart';
import 'package:stock_wise_application/features/product/domain/product_use_cases.dart';

Future<void> testProducts() async {
  final repository = ProductRepositoryImpl(Hive.box<ProductModel>('products'));

  await repository.clearAll();

  final productUseCases = ProductUseCases(repository);

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
    await productUseCases.save(p);
  }
  debugPrint(' CREATE → ${productUseCases.length} produits ajoutés');

  // READ
  debugPrint('\n READ tous les produits :');
  for (final p in productUseCases.products) {
    debugPrint(
      '   - [${p.id}] ${p.name} | qty: ${p.quantity} ${p.unit} | barcode: ${p.barcode ?? "aucun"}',
    );
  }

  // READ — produits critiques (quantity <= minQuantity)
  final lowStock = productUseCases.getLowStock();
  debugPrint('\nLOW STOCK: ${lowStock.length}');
  for (final p in lowStock) {
    debugPrint('  - ${p.name} -> ${p.quantity} ${p.unit} remaining');
  }

  // UPDATE quantité
  final result = await productUseCases.updateQuantity('prod1', 0.2);

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
  final rizUpdated = productUseCases.getProductById("prod1")!;
  debugPrint(
    '   → Critique ? ${rizUpdated.quantity <= rizUpdated.minQuantity ? "OUI" : "NON"}',
  );

  // READ — produits bientôt périmés (dans les 30 prochains jours)
  final expiring = productUseCases.getExpiring(); // clean
  debugPrint('\nEXPIRING SOON: ${expiring.length}');
  for (final p in expiring) {
    debugPrint('  - ${p.name} -> expires ${p.expiryDate}');
  }

  // DELETE
  await productUseCases.delete('prod3');
  debugPrint(
    '\n  DELETE → prod3 supprimé, reste ${productUseCases.length} produits',
  );
}
