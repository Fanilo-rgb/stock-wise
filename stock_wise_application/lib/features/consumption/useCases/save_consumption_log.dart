import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';
import 'package:stock_wise_application/features/consumption/data/repositories/consumption_repository.dart';

class SaveConsumptionLog {
  final ConsumptionRepository _repository;

  SaveConsumptionLog(this._repository);

  Future<void> call(ConsumptionLogModel log) async {
    await _repository.saveConsumptionLog(log);
  }
}
