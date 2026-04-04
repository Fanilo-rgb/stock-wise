import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';
import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository.dart';

class SaveShoppingItem {
  final ShoppingRepository _repository;

  SaveShoppingItem(this._repository);

  Future<void> call(ShoppingItemModel item) async {
    await _repository.saveShoppingItem(item);
  }
}
