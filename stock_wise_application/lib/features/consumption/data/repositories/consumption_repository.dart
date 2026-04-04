import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';

abstract class ConsumptionRepository {
  List<ConsumptionLogModel> getAllConsumptionLogs();
  ConsumptionLogModel? getConsumptionLogById(String id);
  Future<void> saveConsumptionLog(ConsumptionLogModel log);
  Future<void> deleteConsumptionLog(String id);
  Future<void> clearAll();
}
