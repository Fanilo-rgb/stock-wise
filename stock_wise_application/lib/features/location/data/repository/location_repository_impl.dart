import 'package:hive/hive.dart';
import 'package:stock_wise_application/features/location/data/models/location_model.dart';
import 'package:stock_wise_application/features/location/data/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final Box<LocationModel> _box;

  LocationRepositoryImpl(this._box);

  @override
  List<LocationModel> getLocations() {
    return _box.values.toList();
  }

  @override
  LocationModel? getLocationById(String id) {
    return _box.get(id);
  }

  @override
  Future<void> saveLocation(LocationModel location) async {
    await _box.put(location.id, location);
  }

  @override
  Future<void> updateLocation(String id, LocationModel location) async {
    await _box.put(id, location);
  }

  @override
  Future<void> deleteLocation(String id) async {
    await _box.delete(id);
  }

  @override
  Future<void> clearAll() async {
    await _box.clear();
  }
}
