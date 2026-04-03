import 'package:hive/hive.dart';
part 'consumption_log_model.g.dart';

@HiveType(typeId: 6)
class ConsumptionLogModel extends HiveObject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String productId;
  @HiveField(2)
  String productName;
  @HiveField(3)
  double quantityUsed;
  @HiveField(4)
  DateTime date;
  @HiveField(5)
  double? cost;

  ConsumptionLogModel({
    required this.id,
    required this.productId,
    required this.productName,
    required this.quantityUsed,
    required this.date,
    this.cost,
  });
}
