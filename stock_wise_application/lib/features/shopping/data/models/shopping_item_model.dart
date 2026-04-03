import 'package:hive/hive.dart';
part 'shopping_item_model.g.dart';

@HiveType(typeId: 5)
class ShoppingItemModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String productName;
  @HiveField(2)
  double quantity;
  @HiveField(3)
  String unit;
  @HiveField(4)
  bool isBought;
  @HiveField(5)
  String categoryId;

  ShoppingItemModel({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.unit,
    this.isBought = false,
    required this.categoryId,
  });
}
