import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository.dart';

class DeleteShoppingItem {
  final ShoppingRepository _repository;

  DeleteShoppingItem(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteShoppingItem(id);
  }
}
