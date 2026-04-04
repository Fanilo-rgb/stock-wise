import 'package:stock_wise_application/features/household/data/repositories/household_repository.dart';

class DeleteHousehold {
  final HouseholdRepository _repository;

  DeleteHousehold(this._repository);

  Future<void> call(String id) async {
    await _repository.deleteHousehold(id);
  }
}
