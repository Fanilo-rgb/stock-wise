import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 2)
class ProductModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String categoryId;
  @HiveField(3)
  String locationId;
  @HiveField(4)
  double quantity;
  @HiveField(5)
  String unit;
  @HiveField(6)
  DateTime? expiryDate;
  @HiveField(7)
  double minQuantity;
  @HiveField(8)
  String? iconPath;
  @HiveField(9)
  String? barcode;

  ProductModel({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.locationId,
    required this.quantity,
    required this.unit,
    this.expiryDate,
    required this.minQuantity,
    this.iconPath,
    this.barcode,
  });
}
