import 'package:stock_wise_application/features/shopping/data/models/shopping_item_model.dart';
import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository.dart';

class GetShoppingItems {
  final ShoppingRepository _repository;

  GetShoppingItems(this._repository);

  List<ShoppingItemModel> call() => _repository.getAllShoppingItems();
}
