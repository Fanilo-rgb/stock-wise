import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/product/data/models/product_model.dart';

Future<void> testProducts() async {
  final box = Hive.box<ProductModel>('products');
  await box.clear();

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
    await box.put(p.id, p);
  }
  debugPrint(' CREATE → ${box.length} produits ajoutés');

  // READ
  debugPrint('\n READ tous les produits :');
  for (final p in box.values) {
    debugPrint(
      '   - [${p.id}] ${p.name} | qty: ${p.quantity} ${p.unit} | barcode: ${p.barcode ?? "aucun"}',
    );
  }

  // READ — produits critiques (quantity <= minQuantity)
  final critiques = box.values
      .where((p) => p.quantity <= p.minQuantity)
      .toList();
  debugPrint('\n  PRODUITS CRITIQUES : ${critiques.length}');
  for (final p in critiques) {
    debugPrint('   - ${p.name} → ${p.quantity} ${p.unit} restant(s)');
  }

  // UPDATE quantité
  final riz = box.get('prod1')!;
  riz.quantity = 0.5;
  await riz.save();
  debugPrint(
    '\n  UPDATE → Riz quantité mise à ${box.get('prod1')!.quantity} kg',
  );

  // Vérifie si critique après update
  final rizUpdated = box.get('prod1')!;
  debugPrint(
    '   → Critique ? ${rizUpdated.quantity <= rizUpdated.minQuantity ? "OUI" : "NON"}',
  );

  // READ — produits bientôt périmés (dans les 30 prochains jours)
  final soon = DateTime.now().add(const Duration(days: 30));
  final perimes = box.values
      .where((p) => p.expiryDate != null && p.expiryDate!.isBefore(soon))
      .toList();
  debugPrint('\n BIENTÔT PÉRIMÉS : ${perimes.length}');
  for (final p in perimes) {
    debugPrint('   - ${p.name} → expire le ${p.expiryDate}');
  }

  // DELETE
  await box.delete('prod3');
  debugPrint('\n  DELETE → prod3 supprimé, reste ${box.length} produits');
}
