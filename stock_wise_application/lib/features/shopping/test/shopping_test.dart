import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';
import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository_implementation.dart';
import 'package:stock_wise_application/features/shopping/useCases/delete_shopping_item.dart';
import 'package:stock_wise_application/features/shopping/useCases/get_shopping_items.dart';
import 'package:stock_wise_application/features/shopping/useCases/reset_shopping_items.dart';
import 'package:stock_wise_application/features/shopping/useCases/save_shopping_item.dart';

Future<void> testShopping() async {
  final repository = ShoppingRepositoryImplementation(
    Hive.box<ShoppingItemModel>('shopping'),
  );

  final resetShopping = ResetShoppingItems(repository);
  final saveShopping = SaveShoppingItem(repository);
  final getShopping = GetShoppingItems(repository);
  final deleteShopping = DeleteShoppingItem(repository);

  await resetShopping.call();

  debugPrint('\n========== SHOPPING LIST ==========');

  // CREATE
  final items = [
    ShoppingItemModel(
      id: 'shop1',
      productName: 'Lait',
      quantity: 2,
      unit: 'litre',
      isBought: false,
      categoryId: 'cat1',
    ),
    ShoppingItemModel(
      id: 'shop2',
      productName: 'Pain',
      quantity: 1,
      unit: 'pièce',
      isBought: false,
      categoryId: 'cat1',
    ),
    ShoppingItemModel(
      id: 'shop3',
      productName: 'Savon',
      quantity: 3,
      unit: 'pièce',
      isBought: false,
      categoryId: 'cat2',
    ),
  ];
  for (final item in items) {
    await saveShopping.call(item);
  }
  debugPrint(' CREATE → ${getShopping.call().length} articles ajoutés');

  // READ
  debugPrint('\n READ articles :');
  for (final item in getShopping.call()) {
    debugPrint(
      '   - ${item.productName} : ${item.quantity} ${item.unit} [${item.isBought ? '✓' : '✗'}]',
    );
  }

  // UPDATE — marquer comme acheté
  final itemToUpdate = getShopping.call().first;
  itemToUpdate.isBought = true;
  await itemToUpdate.save();
  debugPrint('\n UPDATE → article marqué comme acheté');
  for (final item in getShopping.call()) {
    debugPrint('   - ${item.productName} [${item.isBought ? '✓' : '✗'}]');
  }

  // DELETE
  await deleteShopping.call('shop3');
  debugPrint('\n DELETE → ${getShopping.call().length} articles restants');

  // RESET
  await resetShopping.call();
  debugPrint(
    ' RESET → ${getShopping.call().length} articles après réinitialisation',
  );
}
