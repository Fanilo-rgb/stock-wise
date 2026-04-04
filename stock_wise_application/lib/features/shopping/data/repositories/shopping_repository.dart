import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';

abstract class ShoppingRepository {
  List<ShoppingItemModel> getAllShoppingItems();
  ShoppingItemModel? getShoppingItemById(String id);
  Future<void> saveShoppingItem(ShoppingItemModel item);
  Future<void> updateShoppingItem(ShoppingItemModel item);
  Future<void> deleteShoppingItem(String id);
  Future<void> clearAll();
}
