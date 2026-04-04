import 'package:stock_wise_application/features/household/data/models/household_model.dart';

abstract class HouseholdRepository {
  List<HouseholdModel> getAllHouseholds();
  HouseholdModel? getHouseholdById(String id);
  Future<void> saveHousehold(HouseholdModel household);
  Future<void> deleteHousehold(String id);
  Future<void> clearAll();
}
