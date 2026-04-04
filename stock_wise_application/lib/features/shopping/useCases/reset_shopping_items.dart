import 'package:stock_wise_application/features/shopping/data/repositories/shopping_repository.dart';

class ResetShoppingItems {
  final ShoppingRepository _repository;

  ResetShoppingItems(this._repository);

  Future<void> call() async {
    await _repository.clearAll();
  }
}
