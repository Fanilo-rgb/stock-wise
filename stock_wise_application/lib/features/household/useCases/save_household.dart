import 'package:stock_wise_application/features/household/data/models/household_model.dart';
import 'package:stock_wise_application/features/household/data/repositories/household_repository.dart';

class SaveHousehold {
  final HouseholdRepository _repository;

  SaveHousehold(this._repository);

  Future<void> call(HouseholdModel household) async {
    await _repository.saveHousehold(household);
  }
}
