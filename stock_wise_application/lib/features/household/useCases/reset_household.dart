import 'package:stock_wise_application/features/household/data/repositories/household_repository.dart';

class ResetHousehold {
  final HouseholdRepository _repository;

  ResetHousehold(this._repository);

  Future<void> call() async {
    await _repository.clearAll();
  }
}
