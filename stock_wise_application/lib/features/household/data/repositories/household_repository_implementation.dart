import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/household/data/models/household_model.dart';
import 'household_repository.dart';

class HouseholdRepositoryImplementation implements HouseholdRepository {
  final Box<HouseholdModel> _box;

  HouseholdRepositoryImplementation(this._box);

  @override
  List<HouseholdModel> getAllHouseholds() {
    return _box.values.toList();
  }

  @override
  HouseholdModel? getHouseholdById(String id) {
    final households = _box.values.where((household) => household.id == id);
    return households.isNotEmpty ? households.first : null;
  }

  @override
  Future<void> saveHousehold(HouseholdModel household) async {
    await _box.put(household.id, household);
  }

  @override
  Future<void> deleteHousehold(String id) async {
    final households = _box.values.toList();
    for (int i = 0; i < households.length; i++) {
      if (households[i].id == id) {
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
