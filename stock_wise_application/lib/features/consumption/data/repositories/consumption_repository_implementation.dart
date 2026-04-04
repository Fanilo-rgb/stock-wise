import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';
import 'consumption_repository.dart';

class ConsumptionRepositoryImplementation implements ConsumptionRepository {
  final Box<ConsumptionLogModel> _box;

  ConsumptionRepositoryImplementation(this._box);

  @override
  List<ConsumptionLogModel> getAllConsumptionLogs() {
    return _box.values.toList();
  }

  @override
  ConsumptionLogModel? getConsumptionLogById(String id) {
    final logs = _box.values.where((log) => log.id == id);
    return logs.isNotEmpty ? logs.first : null;
  }

  @override
  Future<void> saveConsumptionLog(ConsumptionLogModel log) async {
    await _box.put(log.id, log);
  }

  @override
  Future<void> deleteConsumptionLog(String id) async {
    final logs = _box.values.toList();
    for (int i = 0; i < logs.length; i++) {
      if (logs[i].id == id) {
        await _box.deleteAt(i);
        break;
      }
    }
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
