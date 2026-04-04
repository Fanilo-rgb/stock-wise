import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';
import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository.dart';

class UpdateShoppingItem {
  final ShoppingRepository _repository;

  UpdateShoppingItem(this._repository);

  Future<void> call(ShoppingItemModel item) async {
    await _repository.updateShoppingItem(item);
  }
}
