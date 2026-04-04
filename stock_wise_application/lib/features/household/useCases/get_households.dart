import 'package:stock_wise_application/features/household/data/models/household_model.dart';
import 'package:stock_wise_application/features/household/data/repositories/household_repository.dart';

class GetHouseholds {
  final HouseholdRepository _repository;

  GetHouseholds(this._repository);

  List<HouseholdModel> call() => _repository.getAllHouseholds();
}
