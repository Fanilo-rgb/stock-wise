import 'package:stock_wise_application/features/consumption/data/models/consumption_log_model.dart';
import 'package:stock_wise_application/features/consumption/data/repositories/consumption_repository.dart';

class GetConsumptionLogs {
  final ConsumptionRepository _repository;

  GetConsumptionLogs(this._repository);

  List<ConsumptionLogModel> call() => _repository.getAllConsumptionLogs();
}
