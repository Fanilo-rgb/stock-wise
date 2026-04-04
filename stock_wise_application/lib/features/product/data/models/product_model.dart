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

  bool get isExpired {
    final date = expiryDate;
    if (date == null) return false;

    return date.isBefore(DateTime.now());
  }

  int? get daysUntilExpiry {
    final date = expiryDate;
    if (date == null) return null;

    return date.difference(DateTime.now()).inDays;
  }

  String get expiryStatus {
    final days = daysUntilExpiry;
    if (days == null) return "No expiry date";
    if (days < 0) return "Expired ${days.abs()}d ago";
    if (days == 0) return "Expires today";
    return "Expires in $days d";
  }
}
