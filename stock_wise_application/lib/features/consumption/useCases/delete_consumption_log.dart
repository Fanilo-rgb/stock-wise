import 'package:stock_wise_application/features/consumption/data/repositories/consumption_repository.dart';

class DeleteConsumptionLog {
  final ConsumptionRepository _repository;

  DeleteConsumptionLog(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteConsumptionLog(id);
  }
}
