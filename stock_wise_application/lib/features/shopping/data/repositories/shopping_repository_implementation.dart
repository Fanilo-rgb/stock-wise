import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';
import 'shopping_repository.dart';

class ShoppingRepositoryImplementation implements ShoppingRepository {
  final Box<ShoppingItemModel> _box;

  ShoppingRepositoryImplementation(this._box);

  @override
  List<ShoppingItemModel> getAllShoppingItems() {
    return _box.values.toList();
  }

  @override
  ShoppingItemModel? getShoppingItemById(String id) {
    final items = _box.values.where((item) => item.id == id);
    return items.isNotEmpty ? items.first : null;
  }

  @override
  Future<void> saveShoppingItem(ShoppingItemModel item) async {
    await _box.put(item.id, item);
  }

  @override
  Future<void> updateShoppingItem(ShoppingItemModel item) async {
    final items = _box.values.toList();
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == item.id) {
        await _box.putAt(i, item);
        break;
      }
    }
  }

  @override
  Future<void> deleteShoppingItem(String id) async {
    final items = _box.values.toList();
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == id) {
        await _box.deleteAt(i);
        break;
      }
    }
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
