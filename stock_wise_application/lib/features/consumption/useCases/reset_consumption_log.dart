import 'package:stock_wise_application/features/consumption/data/repositories/consumption_repository.dart';

class ResetConsumptionLog {
  final ConsumptionRepository _repository;

  ResetConsumptionLog(this._repository);

  Future<void> call() async {
    await _repository.clearAll();
  }
}
